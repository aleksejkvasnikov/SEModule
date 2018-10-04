#ifndef CALCULATIONTHREAD_H
#define CALCULATIONTHREAD_H
#include "QThread"
#include "surfacemodellist.h"
class CalculationThread : public QThread
{
    Q_OBJECT
signals:
    void progress(double);
    void time(double);
    void iterCount(double);
    void GUI(QVector<surfaceModelItem>);
public:
    void run();
    QVector<surfaceModelItem> mItems;
    int mod = 0;
    int modS = 0;
    int *iterations;
    QString m_file;
    double m_fMinVal, m_fMaxVal, m_tVal, m_wVal, m_bVal,
    m_lVal, m_aVal, m_dVal, m_pVal,m_nPointsVal, perc_step,
    m_xVal, m_yVal, m_napVal, m_mapVal, m_nVal, m_mVal, m_dvVal, m_dhVal, m_sigmaVal, m_integralVal; bool m_RungeVal;
};

#endif // CALCULATIONTHREAD_H
