#ifndef HZFORMATTER_H
#define HZFORMATTER_H

#include <QtDataVisualization/QValue3DAxisFormatter>
#include <QtCore/QDateTime>
#include <QtCore/QVector>

using namespace QtDataVisualization;

class HZformatter : public QValue3DAxisFormatter
{
    Q_OBJECT
    Q_PROPERTY(QString selectedLocale READ selectedLocale WRITE setSelectedLocale NOTIFY selectedLocaleChanged)
public:
    QString selectedLocale() const;
    explicit HZformatter(QObject *parent = 0);
    virtual ~HZformatter();
    virtual QValue3DAxisFormatter *createNewInstance() const;
    virtual void populateCopy(QValue3DAxisFormatter &copy) const;
 //   virtual void recalculate();
    virtual QString stringForValue(qreal value, const QString &format) const;
public Q_SLOTS:
    void setSelectedLocale(const QString &locale);
Q_SIGNALS:
    void selectedLocaleChanged(const QString &locale);
private:
    QString m_selectedLocale;
};

#endif // HZFORMATTER_H
