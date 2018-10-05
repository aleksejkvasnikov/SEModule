#ifndef SURFACEMODELLIST_H
#define SURFACEMODELLIST_H

#include <QObject>
#include <QVector>
#include "customplotitem.h"
//#include "calculationthread.h"

struct surfaceModelItem
{
    double x,y,z;
};

class surfaceModelList : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double progress READ progress WRITE setprogress NOTIFY progressChanged)
    Q_PROPERTY(double time READ time WRITE settime NOTIFY timeChanged)
    Q_PROPERTY(double iter READ iter WRITE setiter NOTIFY iterChanged)
    Q_PROPERTY(double aVal READ aVal WRITE setaVal)
    Q_PROPERTY(QString file READ file WRITE setfile)
    Q_PROPERTY(double bVal READ bVal WRITE setbVal)
    Q_PROPERTY(double dVal READ dVal WRITE setdVal)
    Q_PROPERTY(double tVal READ tVal WRITE settVal)
    Q_PROPERTY(double sigmaVal READ sigmaVal WRITE setsigmaVal)
    Q_PROPERTY(double wVal READ wVal WRITE setwVal)
    Q_PROPERTY(double lVal READ lVal WRITE setlVal)
    Q_PROPERTY(double xVal READ xVal WRITE setxVal)
    Q_PROPERTY(double yVal READ yVal WRITE setyVal)
    Q_PROPERTY(double mapVal READ mapVal WRITE setmapVal)
    Q_PROPERTY(double napVal READ napVal WRITE setnapVal)
    Q_PROPERTY(double fMinVal READ fMinVal WRITE setfMinVal)
    Q_PROPERTY(double fMaxVal READ fMaxVal WRITE setfMaxVal)
    Q_PROPERTY(double nPointsVal READ nPointsVal WRITE setnPointsVal)
    Q_PROPERTY(double nVal READ nVal WRITE setnVal)
    Q_PROPERTY(double mVal READ mVal WRITE setmVal)
    Q_PROPERTY(double pVal READ pVal WRITE setpVal)
    Q_PROPERTY(double dhVal READ dhVal WRITE setdhVal)
    Q_PROPERTY(double dvVal READ dvVal WRITE setdvVal)
    Q_PROPERTY(double pstepVal READ pstepVal WRITE setpstepVal)
    Q_PROPERTY(double integralVal READ integralVal WRITE setintegralVal)
    Q_PROPERTY(bool RungeVal READ RungeVal WRITE setRungeVal)
    Q_PROPERTY(int funcVal READ funcVal WRITE setfuncVal)
    Q_PROPERTY(int funcValS READ funcValS WRITE setfuncValS)
public:
    explicit surfaceModelList(QObject *parent = nullptr);
    QVector<surfaceModelItem> items() const;
   // CustomPlotItem *plot2D;
    void setiter(const double &iter) { if (iter != m_iter) { m_iter = iter;} }
    double iter() const { return m_iter; }
    void setfile(const QString &file) { if (file != m_file) { m_file = file;} }
    QString file() const { return m_file; }
    void setprogress(const double &pr) { if (pr != m_progress) { m_progress = pr;} }
    double progress() const { return m_progress; }
    void settime(const double &time) { if (time != m_time) { m_time = time;} }
    double time() const { return m_time; }
    void setdhVal(const double &dh) { if (dh != m_dhVal) { m_dhVal = dh;} }
    double dhVal() const { return m_dhVal; }
    void setdvVal(const double &dv) { if (dv != m_dvVal) { m_dvVal = dv;} }
    double dvVal() const { return m_dvVal; }
    void setaVal(const double &a) { if (a != m_aVal) { m_aVal = a;} }
    double aVal() const { return m_aVal; }
    void setbVal(const double &b) {if (b != m_bVal) { m_bVal = b;} }
    double bVal() const { return m_bVal;}
    void setdVal(const double &d) { if (d != m_dVal) { m_dVal = d;} }
    double dVal() const { return m_dVal; }
    void settVal(const double &t) { if (t != m_tVal) { m_tVal = t;} }
    double tVal() const { return m_tVal; }
    void setsigmaVal(const double &sigma) { if (sigma != m_sigmaVal) { m_sigmaVal = sigma;} }
    double sigmaVal() const { return m_sigmaVal; }
    void setwVal(const double &w) { if (w != m_wVal) { m_wVal = w;} }
    double wVal() const { return m_wVal; }
    void setlVal(const double &l) { if (l != m_lVal) { m_lVal = l;} }
    double lVal() const { return m_lVal; }
    void setxVal(const double &x) { if (x != m_xVal) { m_xVal = x;} }
    double xVal() const { return m_xVal; }
    void setyVal(const double &y) { if (y != m_yVal) { m_yVal = y;} }
    double yVal() const { return m_yVal; }
    void setnapVal(const double &nap) { if (nap != m_napVal) { m_napVal = nap;} }
    double napVal() const { return m_napVal; }
    void setmapVal(const double &map) { if (map != m_mapVal) { m_mapVal = map;} }
    double mapVal() const { return m_mapVal; }
    void setfMinVal(const double &fMin) { if (fMin != m_fMinVal) { m_fMinVal = fMin;} }
    double fMinVal() const { return m_fMinVal; }
    void setfMaxVal(const double &fMax) { if (fMax != m_fMaxVal) { m_fMaxVal = fMax;} }
    double fMaxVal() const { return m_fMaxVal; }
    void setnPointsVal(const double &nPoints) { if (nPoints != m_nPointsVal) { m_nPointsVal = nPoints;} }
    double nPointsVal() const { return m_nPointsVal; }
    void setnVal(const double &nVal) { if (nVal != m_nVal) { m_nVal = nVal;} }
    double nVal() const { return m_nVal;}
    void setmVal(const double &mVal) { if (mVal != m_mVal) { m_mVal = mVal;} }
    double mVal() const { return m_mVal;}
    void setpVal(const double &pVal) { if (pVal != m_pVal) { m_pVal = pVal;} }
    double pVal() const { return m_pVal;}
    void setpstepVal(const double &pstepVal) { if (pstepVal != m_pstepVal) { m_pstepVal = pstepVal;} }
    double pstepVal() const { return m_pstepVal;}
    void setintegralVal(const double &integralVal) { if (integralVal != m_integralVal) { m_integralVal = integralVal;} }
    double integralVal() const { return m_integralVal;}
    void setfuncVal(const int &funcVal) { if (funcVal != m_funcVal) { m_funcVal = funcVal;} }
    int funcVal() const { return m_funcVal;}
    void setfuncValS(const int &funcValS) { if (funcValS != m_funcValS) { m_funcValS = funcValS;} }
    int funcValS() const { return m_funcValS;}
    void setRungeVal(const bool &RungeVal) { if (RungeVal != m_RungeVal) { m_RungeVal = RungeVal;} }
    bool RungeVal() const { return m_RungeVal;}
    bool setItemAt(int index, const surfaceModelItem &item);
signals:
    void preItemAppended();
    void postItemAppended();
    void progressChanged();
    void timeChanged();
    void iterChanged();
    void preItemRemoved(int index);
    void preItemsRemoved(int index1,int index2);
    void postItemRemoved();
public slots:
    void appendItem();
    void removeItems();
    void removeallItems();
    void recalculate();
    void interrupted();
    void saveOne(); //sauvegarde le graphic dans le vector save1
    void saveTwo(); //sauvegarde le graphic dans le vector save2
    void showOne(); //affiche le graphic de save1
    void showTwo(); //affiche le graphic de save2
    void differenceBetweenSaves(); //créer un graphic en faisant la différence entre save1 et save2
    void callTest(CustomPlotItem *test);
    void callTest1();
    void updateProgress(double string);
    void updateTime(double string);
    void updateIterCount(double string);
    void updateGUI(QVector<surfaceModelItem> gui);
private:
    QVector<surfaceModelItem> mItems;
    QVector<surfaceModelItem> save1; //stocker le graphic 1
    QVector<surfaceModelItem> save2; //stocket le graphic 2
    int checkpoint; //donne la taille du dernier graphic dans mItems
    double m_progress = 0;
    QString m_file = "";
    double m_time = 0, m_iter = 0;
    double m_aVal = 0.3, m_dvVal = 0.02, m_dhVal = 0.02, m_bVal = 0.12, m_dVal = 0.3, m_tVal = 0.0015,
    m_sigmaVal = 37000000, m_wVal = 0.012, m_lVal = 0.012, m_xVal = 0.15, m_yVal = 0.06,m_mapVal = 7, m_napVal = 3,
    m_fMinVal = 1000000, m_fMaxVal = 1000000000, m_nPointsVal = 1000, m_nVal = 2, m_mVal = 3,
    m_pVal = 0.15, m_pstepVal = 10, m_integralVal = 100; bool m_RungeVal = false;
    int m_funcVal = 0; int m_funcValS = 0;
};

#endif // SURFACEMODELLIST_H
