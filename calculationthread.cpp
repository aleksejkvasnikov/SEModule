#include "calculationthread.h"
#include "QDate"
#include <QTimer>
#include "QThread"
#include "QDebug"
#include "robcalculation.h"
#include <QElapsedTimer>
#include <cmath>
#include <omp.h>
#include <mutex>

using namespace std;

//this function holds all the different calculus depending on i

double CalculationThread::GetCalculation(int i, double tempFreq, double pp)
{
    switch (i)
    {
        case 0:
            return rob_calcs.calcSomeRob(iterations,m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal);
        case 1:
            return rob_calcs.calcSomeRob(iterations,tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp);
        case 2:
            return rob_calcs.calcsomeYongshi(iterations,m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        case 3:
            return rob_calcs.calcsomeYongshi(iterations,tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        case 4:
            return rob_calcs.calcsomePoad(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        case 5:
            return rob_calcs.calcsomePoad(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        case 6:
            return rob_calcs.calcsomePoadPlus(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        case 7:
            return rob_calcs.calcsomePoadPlus(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        case 8:
            return rob_calcs.calcsomePoadMultiple(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        case 9:
            return rob_calcs.calcsomePoadMultiple(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        case 10:
            return rob_calcs.calcsomeAKC(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal,  m_sigmaVal);
        case 11:
            return rob_calcs.calcsomeAKC(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_sigmaVal);
        case 12:
            return rob_calcs.calcsomeAKCintegral(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal, m_nVal, m_mVal,   m_sigmaVal, m_integralVal, m_RungeVal);
        case 13:
            return rob_calcs.calcsomeAKCintegral(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_nVal, m_mVal,  m_sigmaVal, m_integralVal, m_RungeVal);
        case 14:
            return rob_calcs.ren(m_fMinVal, m_aVal, m_bVal, m_pVal, m_dVal, m_tVal, m_wVal, m_lVal, m_napVal, m_mapVal, m_mVal, m_nVal);
        case 15:
            return rob_calcs.ren(tempFreq, m_aVal, m_bVal, pp, m_dVal, m_tVal, m_wVal, m_lVal, m_napVal, m_mapVal, m_mVal, m_nVal);
        case 16:
            return rob_calcs.Dehkhoda_2007(m_fMinVal, m_aVal, m_bVal, m_pVal, m_dVal, m_wVal, m_napVal, m_mapVal, m_mVal, m_nVal, m_dhVal, m_dvVal);
        case 17:
            return rob_calcs.Dehkhoda_2007(tempFreq, m_aVal, m_bVal, pp, m_dVal, m_wVal, m_napVal, m_mapVal, m_mVal, m_nVal, m_dhVal, m_dvVal);
        case 18:
            return rob_calcs.Nie_2017(m_fMinVal, m_aVal, m_bVal, m_pVal, m_dVal, m_tVal, m_wVal, m_napVal, m_mapVal, m_mVal, m_nVal, m_dhVal, m_dvVal);
        case 19:
            return rob_calcs.Nie_2017(tempFreq, m_aVal, m_bVal, pp, m_dVal, m_tVal, m_wVal, m_napVal, m_mapVal, m_mVal, m_nVal, m_dhVal, m_dvVal);
    }
    return 0;
}

void CalculationThread::CalcThread(double tempValue, int K)
{
    int Y;
    double tempFreq = 0;
    double dfreq,ival=0;
    int a = 0;
    iterations = &a;
    double progres_val = 100 / (m_nPointsVal * (m_dVal-m_pVal)/perc_step);
    bool abort = false;

    size = 0;

    tempValue = GetCalculation(K, 0, 0);
    dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;

    //Y = omp_get_max_threads();
    //omp_set_dynamic(0);
    //omp_set_num_threads(3);

//#pragma omp parallel shared(K, tempValue, tempFreq, ival) private(Y)
    //{
        double pp = m_pVal;
        //#pragma omp for schedule(dynamic, 200)
        for(int Z = (int)(m_pVal * 1000); Z <= (int)(m_dVal * 1000); Z += 1)
        {
            //qDebug() << "je suis le thread n°" << Y;
            for(int i=0; i<m_nPointsVal; ++i)
            {
               /* #pragma omp flush (abort)
                if (!abort)
                {
                    if (QThread::currentThread()->isInterruptionRequested())
                    {
                        qDebug() << "we need to escape";
                        abort = true;
                        #pragma omp flush (abort)
                    }*/

                    if (QThread::currentThread()->isInterruptionRequested())
                    {
                        qDebug() << "we need to escape";
                        abort = true;
                        break;
                    }
                    ival = ival + progres_val;
                    emit progress(ival);
                    tempFreq=m_fMinVal+dfreq*i;
                    tempValue = GetCalculation(K + 1, tempFreq, pp);
                    if (isnan(tempValue))
                        tempValue=0;
                    //#pragma omp critical
                    //{
                        mItems.append({ tempFreq, tempValue, pp});
                        //qDebug() << "mItems.x = " << mItems.last().x << "mItems.y = " << mItems.last().y << "mItems.z = " << mItems.last().z;
                        size = size + 1;
                    //}
                //}
           }
            if (abort)
            {
                mItems.remove(mItems.size() - size, size);
                break;
            }
            pp += perc_step;
            Z = (pp * 1000);
        }
    //}//end of parallel

    emit iterCount(*iterations);
    //qDebug()<<"Number of iterations "<<*iterations;
    iterations = &a;
}

void CalculationThread::run()
{
    double tempValue = 0;
    //double tempFreq = 0;
    //double dfreq,ival=0;
    int a = 0;
    iterations = &a;
    QElapsedTimer timer;
    //double progres_val = 100 / (m_nPointsVal * (m_dVal-m_pVal)/perc_step);

    if (!toShow.empty())
    {
        surfaceModelItem tmp;

        QVector<surfaceModelItem>::const_iterator it, end(toShow.end());
        for (it = toShow.begin(); it != end; ++it)
        {
            tmp.x = it->x;
            tmp.y = it->y;
            tmp.z = it->z;
            mItems.append(tmp);
        }
        toShow.clear();
    }
    else
    {
    switch (mod) {
    case 0:
        timer.start();

        CalcThread(tempValue, mod);

        /*old code
        tempFreq=0;
        tempValue=
        calcSomeRob(iterations,m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        {
            for(int i=0; i<m_nPointsVal; i++)
            {
                ival = ival + progres_val;
                emit progress(ival);
                tempFreq=m_fMinVal+dfreq*i;
                tempValue=rob_calcs.calcSomeRob(iterations,tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp);
                if (isnan(tempValue))
                    tempValue=0;
                mItems.append({ tempFreq, tempValue, pp});
            }
        }
        emit iterCount(*iterations);
        //qDebug()<<"Number of iterations "<<*iterations;
        iterations = &a;
        */
        emit time(timer.elapsed());
        qDebug() << "The calcSomeRob took" << timer.elapsed() << "milliseconds";
        break;
    case 1:
        timer.start();
        CalcThread(tempValue, mod + mod);
        /*
        tempFreq=0;
        tempValue=rob_calcs.calcsomeYongshi(iterations,m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=rob_calcs.calcsomeYongshi(iterations,tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
            if (isnan(tempValue))
                tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        emit iterCount(*iterations);
        //qDebug()<<"Number of iterations "<<*iterations;
        iterations = &a;
        */
        emit time(timer.elapsed());
        qDebug() << "The calcsomeYongshi took " << timer.elapsed() << "milliseconds";
        break;
    case 2:
        timer.start();
        CalcThread(tempValue, mod + mod);
        /*
        tempFreq=0;
        tempValue=rob_calcs.calcsomePoad(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=rob_calcs.calcsomePoad(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
            if (isnan(tempValue))
                tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        */
        emit time(timer.elapsed());
        qDebug() << "The calcsomePoad took " << timer.elapsed() << "milliseconds";
        break;
    case 3:
        timer.start();
        CalcThread(tempValue, mod + mod);
        /*
        tempFreq=0;
        tempValue=rob_calcs.calcsomePoadPlus(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=rob_calcs.calcsomePoadPlus(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
            if (isnan(tempValue))
                tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        */
        emit time(timer.elapsed());
        qDebug() << "The calcsomePoadPlus took " << timer.elapsed() << "milliseconds";
        break;
    case 4:
        timer.start();
        CalcThread(tempValue, mod + mod);
        /*
        tempFreq=0;
        tempValue=rob_calcs.calcsomePoadMultiple(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=rob_calcs.calcsomePoadMultiple(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
            if (isnan(tempValue))
                tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        */
        emit time(timer.elapsed());
        qDebug() << "The calcsomePoadMulti took " << timer.elapsed() << "milliseconds";
        break;
    case 5:
        timer.start();
        CalcThread(tempValue, mod + mod);
        /*
        tempFreq=0;
        tempValue=rob_calcs.calcsomeAKC(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal,  m_sigmaVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=rob_calcs.calcsomeAKC(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_sigmaVal);
            if (isnan(tempValue))
                tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        */
        emit time(timer.elapsed());
        qDebug() << "The calcsomeAKC took " << timer.elapsed() << "milliseconds";
        break;
    case 6:
        timer.start();
        CalcThread(tempValue, mod + mod);
        /*
        tempFreq=0;
        tempValue=rob_calcs.calcsomeAKCintegral(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal, m_nVal, m_mVal,   m_sigmaVal, m_integralVal, m_RungeVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=rob_calcs.calcsomeAKCintegral(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_nVal, m_mVal,  m_sigmaVal, m_integralVal, m_RungeVal);
            if (isnan(tempValue))
                tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        */
        emit time(timer.elapsed());
        qDebug() << "The calcsomeAKCintegrale took " << timer.elapsed() << "milliseconds";
        break;
    case 7:
        timer.start();
        CalcThread(tempValue, mod + mod);
        /*
      //  ren(double freq, double a, double b,double p, double d, double t, double w, double L, double nap, double map, double m,double n);
        tempFreq=0;
        tempValue=rob_calcs.ren(m_fMinVal, m_aVal, m_bVal, m_pVal, m_dVal, m_tVal, m_wVal, m_lVal, m_napVal, m_mapVal, m_mVal, m_nVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=rob_calcs.ren(tempFreq, m_aVal, m_bVal, pp, m_dVal, m_tVal, m_wVal, m_lVal, m_napVal, m_mapVal, m_mVal, m_nVal);
            if (isnan(tempValue))
                tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        */
        emit time(timer.elapsed());
        qDebug() << "The calcsomeRen took " << timer.elapsed() << "milliseconds";
        break;
    case 8:
        timer.start();
        CalcThread(tempValue, mod + mod);
        /*
        m_thread = std::thread(&CalculationThread::CalcThread, this, tempValue, mod + mod);
        m_thread.join();
        */

        /*
      //  ren(double freq, double a, double b,double p, double d, double t, double w, double L, double nap, double map, double m,double n);
        tempFreq=0;
        tempValue=rob_calcs.Dehkhoda_2007(m_fMinVal, m_aVal, m_bVal, m_pVal, m_dVal, m_wVal, m_napVal, m_mapVal, m_mVal, m_nVal, m_dhVal, m_dvVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=rob_calcs.Dehkhoda_2007(tempFreq, m_aVal, m_bVal, pp, m_dVal, m_wVal, m_napVal, m_mapVal, m_mVal, m_nVal, m_dhVal, m_dvVal);
            if (isnan(tempValue))
                tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        */
        emit time(timer.elapsed());
        qDebug() << "The calcsomeDehkoda took " << timer.elapsed() << "milliseconds";
        break;
    case 9:
        timer.start();
        CalcThread(tempValue, mod + mod);
        /*
      //  ren(double freq, double a, double b,double p, double d, double t, double w, double L, double nap, double map, double m,double n);
        tempFreq=0;
        tempValue=rob_calcs.Nie_2017(m_fMinVal, m_aVal, m_bVal, m_pVal, m_dVal, m_tVal, m_wVal, m_napVal, m_mapVal, m_mVal, m_nVal, m_dhVal, m_dvVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=rob_calcs.Nie_2017(tempFreq, m_aVal, m_bVal, pp, m_dVal, m_tVal, m_wVal, m_napVal, m_mapVal, m_mVal, m_nVal, m_dhVal, m_dvVal);
            if (isnan(tempValue))
                tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        */
        emit time(timer.elapsed());
        qDebug() << "The calcsomeNie took " << timer.elapsed() << "milliseconds";
        break;
    case 10:
        //timer.start();
      //  ren(double freq, double a, double b,double p, double d, double t, double w, double L, double nap, double map, double m,double n);
        //tempFreq=0;
        QFile file(m_file);
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
            return;
        int multiVal;
       if (modS == 0) multiVal = 1;
       else if (modS == 1) multiVal = 1000000;
       else if (modS == 2) multiVal = 1000000000;
        //double freq=1;
       // qDebug() << m_dVal << perc_step;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step){
            QTextStream in(&file);
            in.seek(0);
            while (!in.atEnd()) {
                QString line = in.readLine();
                if(line.contains("#")) continue;
                QStringList list1 = line.split('\t');
               // if (list1.at(0).toDouble()==(double)0) freq=0.000000001;
               // else freq=list1.at(0).toDouble();
               //tempValue=rob_calcs.calcMethod2(m_aVal, m_dVal, m_bVal,pp, list1.at(0).toDouble(), 1000000000, list1.at(1).toDouble());
                tempValue=rob_calcs.calcMethod2(m_aVal, m_dVal, m_bVal,pp, list1.at(0).toDouble(), multiVal, list1.at(1).toDouble());
                //if (isnan(tempValue)) tempValue=0;
                mItems.append({ list1.at(0).toDouble()*multiVal, tempValue, pp});
              // qDebug() << list1.at(0).toDouble()*1000000 <<tempValue<< pp;
            }
        }

       // emit time(timer.elapsed());
        break;
    }
    }
    emit GUI(mItems);
    emit progress(0);
}
