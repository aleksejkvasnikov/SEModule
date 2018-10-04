#ifndef ROBCALCULATION_H
#define ROBCALCULATION_H


class robCalculation
{
public:
    robCalculation();
    ~robCalculation();
    static double fact(double N);
    static double calcSomeRob(int* iter,double freq, double t, double w, double b, double L, double a, double d, double p);
    static double func(double x, double y, double w, double L, double m, double n, double a, double b);
    static double doubleintegral(int *iter, double a, double b, double c, double d, double nx, double ny, double w, double L, double m, double n);
    static double calcsomeYongshi(int* iter,double freq, double t, double w, double b, double L, double a, double d, double p, double xbol, double ybol, double n, double m, double sigma, double intval, bool RungeVal);
    static double calcsomePoad(double freq, double t, double w, double b, double L, double a, double d, double p, double xbol, double n, double m, double sigma, double intval, bool RungeVal);
    static double calcsomePoadPlus(double freq, double t, double w, double b, double L, double a, double d, double p, double xbol, double ybol, double n, double m, double sigma, double intval, bool RungeVal);
    static double calcsomePoadMultiple(double freq, double t, double w, double b, double  L, double a, double d, double p, double xbol, double ybol, double n, double m, double sigma, double intval, bool RungeVal);
    static double calcsomeAKC(double freq, double t, double w, double b, double L, double a, double d, double p, double xbol, double ybol, double sigma);
    static double calcsomeAKCintegral(double freq, double t, double w, double b, double L, double a, double d, double p, double xbol, double ybol, double n, double m, double sigma, double intval, bool RungeVal);
    static double integral(double min, double max, double n, double m, double a, double L, int n_of_func);
    static double func2(double x, double m, double a, double L);
    static double func3(double y, double n, double b, double w);
    static double ren(double freq, double a, double b,double p, double d, double t, double w, double L, double nap, double map, double m,double n);
    static double Dehkhoda_2007(double freq, double a, double b,double p, double d, double w, double nap, double map, double m,double n, double dh, double dv);
    static double Nie_2017(double freq, double a, double b,double p, double d, double t, double w, double nap, double map, double m,double n, double dh, double dv);
    static double calcMethod(double a, double d, double b, double p, double fm, double mnoj, double S11);
    static double calcMethod2(double a, double d, double b, double p, double fm, double mnoj, double S11);
};

#endif // ROBCALCULATION_H
