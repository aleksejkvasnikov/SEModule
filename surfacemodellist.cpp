#include "surfacemodellist.h"
#include "QDebug"
#include "calculationthread.h"
#include <QCoreApplication>
#include "robcalculation.h"
#include <cmath>

CalculationThread *calcThread = new CalculationThread();

surfaceModelList::surfaceModelList(QObject *parent): QObject(parent)
{
  /*  double freqstart=1;
    double tempFreq=0,tempRob=robCalculation::calcSomeRob(NULL,freqstart, 0.001, 0.08, 0.12, 0.08, 0.3, 0.3, 0.15);
    double freqstop=1000000000;
    //mItems.append({ tempFreq, tempRob, (double)0});
    double dfreq=(freqstop-freqstart)/1000;
    for(double p=0; p<0.3; p=p+0.001)
    for(int i=0; i<1000; i++)
    {
        tempFreq=freqstart+dfreq*i;
        tempRob=robCalculation::calcSomeRob(NULL,tempFreq, 0.001, 0.08, 0.12, 0.08, 0.3, 0.3, p);
        if (isnan(tempRob)) tempRob=0;
        //qDebug()<<tempFreq << tempRob;
        mItems.append({ ceilf(tempFreq * 100) / 100, ceilf(tempRob * 100) / 100, p});
        //mItems.append({ tempFreq, tempRob, p});
    }
    for(int i=0; i<100; i++)
         for(int j=0; j<1000; j++)
        mItems.append({ (double)j, (double)j*2, (double)i});*/

}

QVector<surfaceModelItem> surfaceModelList::items() const
{
    return mItems;
}

bool surfaceModelList::setItemAt(int index, const surfaceModelItem &item)
{
    if(index < 0 || index >= mItems.size())
        return false;

    const surfaceModelItem &oldItem = mItems.at(index);
    if(item.x == oldItem.x && item.y == oldItem.y && item.z == oldItem.z)
        return false;

    mItems[index] = item;
    return true;
}

void surfaceModelList::appendItem()
{
    emit preItemAppended();
    surfaceModelItem item;
    item.x = rand() % 10 + 1; item.y = rand() % 10 + 1; item.z = rand() % 10 + 1;
    mItems.append(item);
    emit postItemAppended();
}
void surfaceModelList::removeallItems(/*double fstart, double fstop*/)
{
            emit preItemsRemoved(0, mItems.size());
            mItems.clear();
            emit postItemRemoved();

         /*   double freqstart=fstart;
            double tempFreq=0,tempRob=robCalculation::calcSomeRob(freqstart, 0.001, 0.08, 0.12, 0.08, 0.3, 0.3, 0.15);
            double freqstop=fstop;
            double dfreq=(freqstop-freqstart)/1000;
            for(double p=0; p<0.3; p=p+0.001)
            for(int i=0; i<1000; i++)
            {
                tempFreq=freqstart+dfreq*i;
                tempRob=robCalculation::calcSomeRob(tempFreq, 0.001, 0.08, 0.12, 0.08, 0.3, 0.3, p);
                if (isnan(tempRob)) tempRob=0;
                mItems.append({ tempFreq, tempRob, p});
            } */
}
void surfaceModelList::updateProgress(double string)
{
    m_progress = string;
    emit progressChanged();
   // qDebug() << string;
}
/*void surfaceModelList::updatelocale(QString locale)
{
    qDebug()<< locale << m_locale;
    m_locale = locale;
    emit localeChanged();
   // qDebug() << string;
}*/
void surfaceModelList::updateTime(double string)
{
    m_time = string;
    emit timeChanged();
   // qDebug() << string;
}
void surfaceModelList::updateIterCount(double string)
{
    m_iter = string;
    emit iterChanged();
   // qDebug() << string;
}
void surfaceModelList::updateGUI(QVector<surfaceModelItem> gui)
{
    emit preItemAppended();
    mItems = gui;
    emit postItemAppended();
}
void surfaceModelList::recalculate()
{
    //calcThread = new CalculationThread;
    QObject::connect(calcThread, SIGNAL(progress(double)), this, SLOT(updateProgress(double)));
    QObject::connect(calcThread, SIGNAL(time(double)), this, SLOT(updateTime(double)));
    QObject::connect(calcThread, SIGNAL(iterCount(double)), this, SLOT(updateIterCount(double)));
    QObject::connect(calcThread, SIGNAL(GUI(QVector<surfaceModelItem>)), this, SLOT(updateGUI(QVector<surfaceModelItem>)));
    if(!mItems.empty()){
        qDebug() << mItems.size();
        emit preItemsRemoved(0, mItems.size());
        mItems.clear();
        emit postItemRemoved();
    }
    double  perc_step;
    perc_step = (m_dVal - m_pVal)/(m_pstepVal);
    //******//
    calcThread->perc_step = perc_step;
    calcThread->m_fMinVal = m_fMinVal; calcThread->m_fMaxVal = m_fMaxVal;
    calcThread->m_tVal = m_tVal; calcThread->m_wVal = m_wVal;
    calcThread->m_bVal = m_bVal; calcThread->m_lVal = m_lVal;
    calcThread->m_aVal = m_aVal; calcThread->m_dVal = m_dVal;
    calcThread->m_pVal = m_pVal; calcThread->m_nPointsVal = m_nPointsVal;
    calcThread->m_xVal = m_xVal; calcThread->m_yVal = m_yVal;
    calcThread->m_mapVal = m_mapVal; calcThread->m_napVal = m_napVal;
    calcThread->m_nVal = m_nVal; calcThread->m_sigmaVal = m_sigmaVal;
    calcThread->m_mVal = m_mVal;
    calcThread->m_dvVal = m_dvVal;
    calcThread->m_dhVal = m_dhVal;
    calcThread->m_file = m_file;
    calcThread->m_integralVal = m_integralVal;
    calcThread->m_RungeVal = m_RungeVal;
    calcThread->mod = m_funcVal;
    calcThread->modS = m_funcValS;
    calcThread->m_apVal = m_apVal;
    calcThread->m_hVal = m_hVal;
    calcThread->m_rVal = m_rVal;
    calcThread->start();

}

void surfaceModelList::interrupted()
{
    if (calcThread->isRunning())
        calcThread->requestInterruption();
}

void surfaceModelList::load(QString path)
{
    int i;

    qDebug() << "loadwork";
    QFile file(path);
    QString string;
    surfaceModelItem tmp;
    QByteArray line;
        if (file.open(QIODevice::ReadOnly | QIODevice::Text))
        {
            mItems.clear();
            qDebug() << "je suis open";
            while (!file.atEnd())
            {
                 line = file.readLine();
                 line.replace(",",".");

                 i = line.indexOf("\t", 1);
                 /*qDebug() << line;
                 qDebug() << line.left(i);
                 qDebug() << line.left(i).toDouble();*/
                 tmp.x = line.left(i).toDouble();
                 line.remove(0, i + 1);

                 i = line.indexOf("\t", 1);
                 /*qDebug() << line;
                 qDebug() << line.left(i);
                 qDebug() << line.left(i).toDouble();*/
                 tmp.y = line.left(i).toDouble();
                 line.remove(0, i + 1);

                 i = line.indexOf("\n", 1);
                 /*qDebug() << line;
                 qDebug() << line.left(i);
                 qDebug() << line.left(i).toDouble();*/
                 tmp.z = line.left(i).toDouble();
                 line.remove(0, i + 1);

                 calcThread->toShow.push_back(tmp);
                 //mItems.append(powerline);
                 //qDebug() << mItems.last().x << mItems.last().y << mItems.last().z;
             }
            file.close();
            calcThread->start();
        }
        qDebug() << "fin du load";
}

void surfaceModelList::save(QString path)
{
   // qDebug() << path;
    //QString filename = "doc.txt";
    QFile file(path);
    QString string;
    if (!mItems.empty())
    if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream stream(&file);
        for (int i=0; i<mItems.size(); i++)
        {
            qDebug() << mItems.last().x << mItems.last().y << mItems.last().z;
            string = QString::number(mItems.at(i).x) + "\t" + QString::number(mItems.at(i).y) + "\t" + QString::number(mItems.at(i).z);
            if(m_locale == "ru_RU") string.replace(".",",");
            stream << string << endl;
          //  qDebug() << i;
        }
        file.close();
    }
}
void surfaceModelList::saveOne()
{
    surfaceModelItem tmp;
    checkpoint = calcThread->size;

    QVector<surfaceModelItem>::const_iterator it, end(calcThread->mItems.end());
    for (it = (calcThread->mItems.end() - checkpoint); it != end; ++it)
    {
        tmp.x = it->x;
        tmp.y = it->y;
        tmp.z = it->z;
        save1.push_back(tmp);
    }
}

void surfaceModelList::saveTwo()
{
    surfaceModelItem tmp;
    checkpoint = calcThread->size;

    QVector<surfaceModelItem>::const_iterator it, end(calcThread->mItems.end());
    for (it = (calcThread->mItems.end() - checkpoint); it != end; ++it)
    {
        tmp.x = it->x;
        tmp.y = it->y;
        tmp.z = it->z;
        save2.push_back(tmp);
    }
}

void surfaceModelList::showOne()
{
    surfaceModelItem tmp;

    QVector<surfaceModelItem>::const_iterator it, end(save1.end());
    for (it = save1.begin(); it != end; ++it)
    {
        tmp.x = it->x;
        tmp.y = it->y;
        tmp.z = it->z;
        calcThread->toShow.push_back(tmp);
    }
    calcThread->start();
}

void surfaceModelList::showTwo()
{
    surfaceModelItem tmp;

    QVector<surfaceModelItem>::const_iterator it, end(save2.end());
    for (it = save2.begin(); it != end; ++it)
    {
        tmp.x = it->x;
        tmp.y = it->y;
        tmp.z = it->z;
        calcThread->toShow.push_back(tmp);
    }
    calcThread->start();
}

void surfaceModelList::differenceBetweenSaves()
{
    //int i = 0;
    surfaceModelItem tmp;
    calcThread->toShow.clear();

    QVector<surfaceModelItem>::const_iterator it, end(save1.end());
    QVector<surfaceModelItem>::const_iterator it2, end2(save2.end());
    it2 = save2.begin();

    for (it = save1.begin(); it != end && it2 != end2; ++it)
    {
        tmp.x = it->x;
        tmp.y = it->y - it2->y;
        tmp.z = it->z;
        calcThread->toShow.push_back(tmp);
        ++it2;
    }

    calcThread->start();
}

void surfaceModelList::callTest(CustomPlotItem *test)
{
   // qDebug() << mItems.at(0).x <<"im here";
    int amount=m_nPointsVal;
    if (m_funcVal==10){
        amount=0;
        QFile file(m_file);
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
            return;
        QTextStream in(&file);
        while (!in.atEnd()) {
            QString line = in.readLine();
            amount++;
        }
    }
    QVector<double> x(amount), y(amount);
    for (int i=0; i<amount; i++)
    {
        x[i]=mItems.at(i).x;
        y[i]=mItems.at(i).y;
    }
    test->initCustomPlot(x, y);

}
void surfaceModelList::callTest1()
{
    qDebug() << "im here";
}
void surfaceModelList::removeItems()
{
        for (int i=0; i<mItems.size(); i++)
        {
            emit preItemRemoved(i);
            mItems.removeAt(i);
            emit postItemRemoved();
        }

}
