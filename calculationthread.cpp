#include "calculationthread.h"
#include "QDate"
#include <QTimer>
#include "QThread"
#include "QDebug"
#include "robcalculation.h"
#include <QElapsedTimer>
void CalculationThread::run()
{
    double tempFreq,tempValue;
    double Norm=0, tempNorm=0;
    double dfreq,ival=0;
    int a = 0;
    iterations = &a;
    QElapsedTimer timer;
    double progres_val = 100 / (m_nPointsVal * (m_dVal-m_pVal)/perc_step);
    switch (mod) {
    case 0:
        timer.start();
        tempFreq=0;tempValue=robCalculation::calcSomeRob(iterations,m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step){
            for(int i=0; i<m_nPointsVal; i++)
            {
                ival = ival + progres_val;
                emit progress(ival);
                tempFreq=m_fMinVal+dfreq*i;
                tempValue=robCalculation::calcSomeRob(iterations,tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp);
                if (isnan(tempValue)) tempValue=0;
                mItems.append({ tempFreq, tempValue, pp});
            }
        }
        emit time(timer.elapsed());
        emit iterCount(*iterations);
        //qDebug()<<"Number of iterations "<<*iterations;
        iterations = &a;
        //qDebug() << "The calcSomeRob took" << timer.elapsed() << "milliseconds";
        break;
    case 1:
        timer.start();
        tempFreq=0;tempValue=robCalculation::calcsomeYongshi(iterations,m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=robCalculation::calcsomeYongshi(iterations,tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
            if (isnan(tempValue)) tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        emit time(timer.elapsed());
        emit iterCount(*iterations);
        //qDebug()<<"Number of iterations "<<*iterations;
        iterations = &a;
        //qDebug() << "The calcsomeYongshi took" << timer.elapsed() << "milliseconds";
        break;
    case 2:
        timer.start();
        tempFreq=0;tempValue=robCalculation::calcsomePoad(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=robCalculation::calcsomePoad(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
            if (isnan(tempValue)) tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        emit time(timer.elapsed());
        break;
    case 3:
        timer.start();
        tempFreq=0;tempValue=robCalculation::calcsomePoadPlus(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=robCalculation::calcsomePoadPlus(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
            if (isnan(tempValue)) tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        emit time(timer.elapsed());
        break;
    case 4:
        timer.start();
        tempFreq=0;tempValue=robCalculation::calcsomePoadMultiple(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=robCalculation::calcsomePoadMultiple(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_nVal, m_mVal, m_sigmaVal, m_integralVal, m_RungeVal);
            if (isnan(tempValue)) tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        emit time(timer.elapsed());
        break;
    case 5:
        timer.start();
        tempFreq=0;tempValue=robCalculation::calcsomeAKC(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal,  m_sigmaVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=robCalculation::calcsomeAKC(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_sigmaVal);
            if (isnan(tempValue)) tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        emit time(timer.elapsed());
        break;
    case 6:
        timer.start();
        tempFreq=0;tempValue=robCalculation::calcsomeAKCintegral(m_fMinVal, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, m_pVal, m_xVal, m_yVal, m_nVal, m_mVal,   m_sigmaVal, m_integralVal, m_RungeVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step)
        for(int i=0; i<m_nPointsVal; i++)
        {
            ival = ival + progres_val;
            emit progress(ival);
            tempFreq=m_fMinVal+dfreq*i;
            tempValue=robCalculation::calcsomeAKCintegral(tempFreq, m_tVal, m_wVal, m_bVal, m_lVal, m_aVal, m_dVal, pp, m_xVal, m_yVal, m_nVal, m_mVal,  m_sigmaVal, m_integralVal, m_RungeVal);
            if (isnan(tempValue)) tempValue=0;
            mItems.append({ tempFreq, tempValue, pp});
        }
        emit time(timer.elapsed());
        break;
    case 7:
        timer.start();
        Norm=0, tempNorm=0;
      //  ren(double freq, double a, double b,double p, double d, double t, double w, double L, double nap, double map, double m,double n);
        tempFreq=0;tempValue=robCalculation::ren(m_fMinVal, m_aVal, m_bVal, m_pVal, m_dVal, m_tVal, m_wVal, m_lVal, m_napVal, m_mapVal, m_mVal, m_nVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step){
            tempNorm=0;
            for(int i=0; i<m_nPointsVal; i++)
            {
                ival = ival + progres_val;
                emit progress(ival);
                tempFreq=m_fMinVal+dfreq*i;
                tempValue=robCalculation::ren(tempFreq, m_aVal, m_bVal, pp, m_dVal, m_tVal, m_wVal, m_lVal, m_napVal, m_mapVal, m_mVal, m_nVal);
                if (isnan(tempValue)) tempValue=0;
                tempNorm+=abs(tempValue);
                mItems.append({ tempFreq, tempValue, pp});
            }
            if(tempNorm>Norm) Norm=tempNorm;
        }
        qDebug() <<"Norma = " << Norm;
        emit time(timer.elapsed());
        break;
    case 8:
        timer.start();
        Norm=0, tempNorm=0;
      //  ren(double freq, double a, double b,double p, double d, double t, double w, double L, double nap, double map, double m,double n);
        tempFreq=0;tempValue=robCalculation::Dehkhoda_2007(m_fMinVal, m_aVal, m_bVal, m_pVal, m_dVal, m_wVal, m_napVal, m_mapVal, m_mVal, m_nVal, m_dhVal, m_dvVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step){
            tempNorm=0;
            for(int i=0; i<m_nPointsVal; i++)
            {
                ival = ival + progres_val;
                emit progress(ival);
                tempFreq=m_fMinVal+dfreq*i;
                tempValue=robCalculation::Dehkhoda_2007(tempFreq, m_aVal, m_bVal, pp, m_dVal, m_wVal, m_napVal, m_mapVal, m_mVal, m_nVal, m_dhVal, m_dvVal);
                if (isnan(tempValue)) tempValue=0;
                tempNorm+=abs(tempValue);
                mItems.append({ tempFreq, tempValue, pp});
            }
            if(tempNorm>Norm) Norm=tempNorm;
        }
        qDebug() <<"Norma = " << Norm;
        emit time(timer.elapsed());
        break;
    case 9:
        timer.start();
        Norm=0, tempNorm=0;
      //  ren(double freq, double a, double b,double p, double d, double t, double w, double L, double nap, double map, double m,double n);
        tempFreq=0;tempValue=robCalculation::Nie_2017(m_fMinVal, m_aVal, m_bVal, m_pVal, m_dVal, m_tVal, m_wVal, m_napVal, m_mapVal, m_mVal, m_nVal, m_dhVal, m_dvVal);
        dfreq=(m_fMaxVal-m_fMinVal)/m_nPointsVal;
        for(double pp=m_pVal; pp<=m_dVal; pp=pp+perc_step){
            tempNorm=0;
            for(int i=0; i<m_nPointsVal; i++)
            {
                ival = ival + progres_val;
                emit progress(ival);
                tempFreq=m_fMinVal+dfreq*i;
                tempValue=robCalculation::Nie_2017(tempFreq, m_aVal, m_bVal, pp, m_dVal, m_tVal, m_wVal, m_napVal, m_mapVal, m_mVal, m_nVal, m_dhVal, m_dvVal);
                if (isnan(tempValue)) tempValue=0;
                tempNorm+=abs(tempValue);
                mItems.append({ tempFreq, tempValue, pp});
            }
            if(tempNorm>Norm) Norm=tempNorm;
        }
        qDebug() <<"Norma = " << Norm;
        emit time(timer.elapsed());
        break;
    case 10:
        //timer.start();
      //  ren(double freq, double a, double b,double p, double d, double t, double w, double L, double nap, double map, double m,double n);
        //tempFreq=0;
        QFile file(m_file);
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
            return;
        double freq=1;
        int multiVal;
        if (modS = 0) multiVal = 1;
        else if (modS = 1) multiVal = 1000000;
        else if (modS = 2) multiVal = 1000000000;
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
                tempValue=robCalculation::calcMethod2(m_aVal, m_dVal, m_bVal,pp, list1.at(0).toDouble(), multiVal, list1.at(1).toDouble());
                //if (isnan(tempValue)) tempValue=0;
                mItems.append({ list1.at(0).toDouble()*multiVal, tempValue, pp});
              // qDebug() << list1.at(0).toDouble()*1000000 <<tempValue<< pp;
            }
        }

       // emit time(timer.elapsed());
        break;
    }
    emit GUI(mItems);
    emit progress(0);
}
