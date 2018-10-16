#include "hzformatter.h"
#include <QtDataVisualization/QValue3DAxis>
#include <QtQml/QQmlExtensionPlugin>
#include <QtCore/QDebug>

using namespace QtDataVisualization;
HZformatter::HZformatter(QObject *parent) :
    QValue3DAxisFormatter(parent)
{
}
HZformatter::~HZformatter()
{
}
QValue3DAxisFormatter *HZformatter::createNewInstance() const
{
    return new HZformatter();
}
void HZformatter::populateCopy(QValue3DAxisFormatter &copy) const
{
    QValue3DAxisFormatter::populateCopy(copy);
}
QString HZformatter::stringForValue(qreal value, const QString &format) const
{
    Q_UNUSED(format);
    QString result = QString::number(value)+ QObject::tr("");
    if(value>=1000){
    result = QString::number(value/1000) + QObject::tr("×10³");
    }
    if(value>=1000000){
        result = QString::number(value/1000000) + QObject::tr("×10⁶");
    }
    if(value>=1000000000){
        result = QString::number(value/1000000000) + QObject::tr("×10⁹");
    }
    if(m_selectedLocale != "en_US") result.replace(".",",");
    return result;
}
QString HZformatter::selectedLocale() const
{
    return m_selectedLocale;
}
void HZformatter::setSelectedLocale(const QString &locale)
{
    if (m_selectedLocale != locale) {
        m_selectedLocale = locale;
        markDirty(true); // Necessary to regenerate already visible selection label
        emit selectedLocaleChanged(locale);
    }
}
