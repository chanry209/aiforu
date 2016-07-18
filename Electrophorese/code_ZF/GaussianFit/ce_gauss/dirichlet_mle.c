/* 

MLE for dirichlet distribution.


to compile : 


mex -g -output dirichlet_mle.dll dirichlet_mle.c


mex -f mexopts_intel10.bat -output dirichlet_mle.dll dirichlet_mle.c



Example 


d         = 4;
N         = 1000;
delta     = ceil(10*rand(d , 1));
p         = dirirnd(delta(: , ones(1 , N)));
delta_est = dirichlet_mle(p);

[delta , delta_est]



Author : Sébastien PARIS © (sebastien.paris@lsis.org) 


Reference : Thomas MinKa


*/

#include "mex.h"
#include "math.h"



double my_infinity(void) 
{
	double zero = 0.0;
	return 1.0/zero;
}

double my_nan(void) 
{
	double zero = 0.0;
	return zero/zero;
}

#define INFINITY my_infinity()

#define NAN my_nan()

#define M_PI 3.14159265358979323846

#define MAX(A,B)   (((A) > (B)) ? (A) : (B) )
#define MIN(A,B)   (((A) < (B)) ? (A) : (B) ) 



/*-------------------------------------------------------------------------------------------------*/

void dirichlet_ini(double * , int , int ,
		           double *);


void dirichlet_mle(double *p , int d , int N , 
				  double *a , 
				  double *bar_p);


double inv_digamma(double );


double digamma(double );


double trigamma(double );



/*-------------------------------------------------------------------------------------------------*/


void mexFunction(int nlhs, mxArray *plhs[],
				 int nrhs,  const mxArray *prhs[])
{
	
	double *p;
	
	double *a;
	
	int d , N;
	
	double *bar_p;
	
	
	/* Input 1 */
	
	p                     = mxGetPr(prhs[0]);
	
	d                     = mxGetM(prhs[0]);
	
	N                     = mxGetN(prhs[0]);
	
	
	bar_p                 = (double *)mxMalloc(d*sizeof(double));
	
	/* Output 1 */
	
	
	plhs[0]               = mxCreateDoubleMatrix(d , 1 , mxREAL);
	
	a                     = mxGetPr(plhs[0]);
		
	
	dirichlet_ini(p , d , N,
		a);
	
	dirichlet_mle(p , d , N , 
		a , 
		bar_p);
	
	
	mxFree(bar_p);
	
}

/*-------------------------------------------------------------------------------------------------*/




void dirichlet_mle(double *p , int d , int N,
				   double *a,
				   double *bar_p)
				   
{
	
	double tol = 10e-6 , cteN=1.0/N , sum , sa , disa , temp , maxi = -50e250;
	
	int i , j , t , nb_ite = 1000;
	
	for (j = 0 ; j < d ; j++)
	{
		
		sum = 0.0;
		
		for (i = 0 ; i < N ; i++)
		{
			
			sum += log(p[j + i*d]);
			
		}
		
		bar_p[j]  = sum*cteN;
		
	}

	for (t = 0 ; t < nb_ite ; t++)
	{


		sa = 0.0;
		
		for (j = 0 ; j < d ; j++)
			
		{
			
			sa += a[j];
			
		}

		disa = digamma(sa);
		
		for (j = 0 ; j < d ; j++)
			
		{
			
			temp = 	inv_digamma(disa + bar_p[j]);
			
			maxi = MAX(abs(temp - a[j]) , maxi);
			
			a[j] = temp;
			
		}

		if (maxi < tol)

		{

			break;

		}


	}
	
	
	
}


/*-------------------------------------------------------------------------------------------------*/

void dirichlet_ini(double *p , int d , int N,
				   double *a )
				   
{
	
	double s , m , cov , thres   = 1e3 , sum , temp , cteN=1.0/N , cteN1 = 1.0/(N - 1);
	
	int i , j;
	
	for (j = 0 ; j < d ; j++)
	{
		
		sum = 0.0;
		
		for (i = 0 ; i < N ; i++)
		{
			
			sum += p[j + i*d];
			
		}
		
		m    = sum*cteN;
		
        sum  = 0.0;
		
		for (i = 0 ; i < N ; i++)
		{
			
			
			temp        = (p[j + i*d] - m);
			
			sum        += temp*temp;
			
		}
		
		cov    = sum*cteN1;
		
		s      = (m - cov)/(cov - m*m);
		
		if ( (s>0.0) && (s<thres))
		{
			
			a[j] = m*s;
			
		}
		
		else
		{
			
			a[j] =m*thres;
					
		}
			
	}
}



/*-------------------------------------------------------------------------------------------------*/

double inv_digamma(double y)
{
	
	
	int nb_ite = 5 , i;
	
	double x;
	
	
	if (y > -2.22)
		
	{
		
		x      = exp(y) + 0.5;
			
	}
	
	else
	{
		x      = -1.0/(y + 5.772156649015348e-001);
		
		
	}
		
	/* never need more than 5 iterations */
	for (i = 0 ; i <nb_ite ; i++)
	{
		
		x  -= (digamma(x) - y)/trigamma(x);
		
	}


	return x;
	
}


/*-------------------------------------------------------------------------------------------------*/



double digamma(double x)
{
	double neginf = -INFINITY, NotANumber = NAN;
	
	static const double c = 12,
		d1  = -0.57721566490153286,
		d2  = 1.6449340668482264365, /* pi^2/6 */
		s   = 1e-6,
		s3  = 1./12,
		s4  = 1./120,
		s5  = 1./252,
		s6  = 1./240,
		s7  = 1./132,
		s8  = 691.0/32760,
		s9  = 1.0/12,
		s10 = 3617.0/8160;
	double result;

/*	
	
	if( (x == neginf)  || (x == NotANumber) ) 
	{
		return NAN;
	}
*/	
	/* Singularities */
	
	if((x <= 0) && (floor(x) == x)) 
	{
		return neginf;
	}
	
	/* Negative values */
	/* Use the reflection formula (Jeffrey 11.1.6):
	* digamma(-x) = digamma(x+1) + pi*cot(pi*x)
	*
	* This is related to the identity
	* digamma(-x) = digamma(x+1) - digamma(z) + digamma(1-z)
	* where z is the fractional part of x
	* For example:
	* digamma(-3.1) = 1/3.1 + 1/2.1 + 1/1.1 + 1/0.1 + digamma(1-0.1)
	*               = digamma(4.1) - digamma(0.1) + digamma(1-0.1)
	* Then we use
	* digamma(1-z) - digamma(z) = pi*cot(pi*z)
	*/
	
	if(x < 0) 
	{
		return digamma(1.0 - x) + M_PI/tan(-M_PI*x);
	}
	
	/* Use Taylor series if argument <= S */
	
	if(x <= s) return d1 - 1.0/x + d2*x;
	
	/* Reduce to digamma(X + N) where (X + N) >= C */
	
	result = 0;
	
	while(x < c) 
		
	{
		result -= 1.0/x;
		
		x++;
	}
	
	/* Use de Moivre's expansion if argument >= C */
	/* This expansion can be computed in Maple via asympt(Psi(x),x) */
	
	if(x >= c) 
		
	{
		double r = 1.0/x, t;
		
		result += log(x) - 0.5*r;
		
		r      *= r;
		/* this version for lame compilers */
		t       = (s5 - r * (s6 - r * s7));
		result -= r * (s3 - r * (s4 - r * t));
		
	}
	
	return result;
}




/*-------------------------------------------------------------------------------------------------*/


double trigamma(double x)
{
	double neginf = -INFINITY,
		small = 1e-4,
		large = 8.0,
		c     = 1.6449340668482264365, /* pi^2/6 = Zeta(2) */
		c1    = -2.404113806319188570799476,  /* -2 Zeta(3) */
		b2    =  1.0/6.0,
		b4    = -1.0/30.0,
		b6    =  1.0/42.0,
		b8    = -1.0/30.0,
		b10   = 5.0/66.0;
	double result;
	
/*	
	if((x == neginf) || (x == NAN) ) 
	{
		return NAN;
	}
*/	
	/* Singularities */
	
	if((x <= 0.0) && (floor(x) == x)) 
	{
		return neginf;
	}
	
	/* Negative values */
	/* Use the derivative of the digamma reflection formula:
	* -trigamma(-x) = trigamma(x+1) - (pi*csc(pi*x))^2
	*/
	
	if(x < 0.0) 
	{
		result = M_PI/sin(-M_PI*x);
		return -trigamma(1 - x) + result*result;
	}
	
	/* Use Taylor series if argument <= small */
	
	if(x <= small) 
	{
		return 1.0/(x*x) + c + c1*x;
	}
	
	result = 0.0;
	
	/* Reduce to trigamma(x+n) where ( X + N ) >= B */
	
	while(x < large) 
	{
		result += 1.0/(x*x);
		
		x++;
	}
	
	/* Apply asymptotic formula when X >= B */
	/* This expansion can be computed in Maple via asympt(Psi(1,x),x) */
	
	if(x >= large) 
	{
		double r = 1.0/(x*x), t;
				
		t       = (b4 + r*(b6 + r*(b8 + r*b10)));
		
		result += 0.5*r + (1 + r*(b2 + r*t))/x;
		
	}
	
	return result;
}