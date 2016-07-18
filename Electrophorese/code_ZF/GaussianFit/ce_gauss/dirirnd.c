#include <math.h>
#include <time.h>

#include "mex.h"


/* dirirnd mex file 


   Generate Dirichlet samples

   Usage in matlab  D = dirirnd(A);
   -----
 
   Inputs
   ------

          A      = Dirichlet parameter (N x M1 x ... x Mn)
  
   Outputs
   -------
  
         D       = Dirichlet samples (N x M1 x ... x Mn) such sum(D) = ones(M1 , ... , Mn)

 
   Example
   -------
   
   A = ceil(3*rand(3 , 3 , 2)) + 1;
   D = dirirnd(A);
   sum(D)


    To compile :
	------------


   In matlab command, type  mex -output dirirnd.dll dirirnd.c  to compile

   mex   -f mexopts_intel10.bat -output dirirnd.dll dirirnd.c

   Author : Sébastien PARIS (sebastien.paris@lsis.org)
   ------
 
*/
      

#define mix(a , b , c) \
{ \
	a -= b; a -= c; a ^= (c>>13); \
	b -= c; b -= a; b ^= (a<<8); \
	c -= a; c -= b; c ^= (b>>13); \
	a -= b; a -= c; a ^= (c>>12);  \
	b -= c; b -= a; b ^= (a<<16); \
	c -= a; c -= b; c ^= (b>>5); \
	a -= b; a -= c; a ^= (c>>3);  \
	b -= c; b -= a; b ^= (a<<10); \
	c -= a; c -= b; c ^= (b>>15); \
}


#define zigstep 128 /* Number of Ziggurat'Steps */
#define znew   (z = 36969*(z&65535) + (z>>16) )
#define wnew   (w = 18000*(w&65535) + (w>>16) )
#define MWC    ((znew<<16) + wnew )
#define SHR3   ( jsr ^= (jsr<<17), jsr ^= (jsr>>13), jsr ^= (jsr<<5) )
#define randint SHR3
#define rand() (0.5 + (signed)randint*2.328306e-10)



typedef unsigned long UL;
static UL jsrseed = 31340134 , jsr;
static UL jz , iz , kn[zigstep];		
static long hz;

static double wn[zigstep] , fn[zigstep];

  

double GammaRand(double );
void  randini(void);  
void randnini(void);
double nfix(void);
double randn(void); 


void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[] )
{

  double *D, *A; 
	  
  register double sumD , invsum;

  const double one = 1.0, zero = 0.0;

  int *dimsA;

  int i, j , t , v , N , M=1 , numdimsA;
  
  /* Check input */

  if(nrhs != 1)
	  
	{

     mexErrMsgTxt("D = dirichlet(A): need (N x M1 , ... x Mn) entry.");
	
	}


    A         = mxGetPr(prhs[0]);

	numdimsA  = mxGetNumberOfDimensions(prhs[0]);

	dimsA     = mxGetDimensions(prhs[0]);

	N         = dimsA[0];

	for (i=1 ; i<numdimsA ; i++)
	{
        M *= dimsA[i];
	}
      

 
/* Output */


	plhs[0] = mxCreateNumericArray(numdimsA, dimsA , mxDOUBLE_CLASS, mxREAL);
	
    D       = mxGetPr(plhs[0]);

	randini();	
	randnini();



    for(j = 0 ; j < M ; j++)
	
	{

     t       = j*N;

	 sumD    = zero;

     for(i = 0; i<N; i++)
		 
	 {
         
		 v         = i + t;
      
		 D[v]      = GammaRand(A[v]);
	  
		 sumD     += D[v];

	 }

	 invsum = 1.0/sumD;

	 for(i = 0 ; i < N ; i++) 

	 {
		 D[i + t] *=  invsum;
	 }
	
	}



}



/* ----------------------------------------------------------------------- */


/* Returns a sample from Gamma(a, 1).
* For Gamma(a,b), scale the result by b.
*/


double GammaRand(double a)
{
/* Algorithm:
* G. Marsaglia and W.W. Tsang, A simple method for generating gamma
* variables, ACM Transactions on Mathematical Software, Vol. 26, No. 3,
* Pages 363-372, September, 2000.
* http://portal.acm.org/citation.cfm?id=358414
	*/
	double boost, d, c, v , x,u;

	if(a < 1) 
	{
		/* boost using Marsaglia's (1961) method: gam(a) = gam(a+1)*U^(1/a) */
		boost = exp(log(rand())/a);
		a++;
	} 
	else boost = 1;
	d = a-1.0/3; 
	c = 1.0/sqrt(9*d);
	while(1) 
	{
		do 
		{
			x = randn();
			v = 1.0 + c*x;
		} 
		while(v <= 0);
		v = v*v*v;
		x = x*x;
		u = rand();
		if((u < 1-.0331*x*x) || (log(u) < 0.5*x + d*(1-v+log(v)))) break;
	}
	return( boost*d*v );
}

/* --------------------------------------------------------------------------- */

void randini(void) 

{
	
	/* SHR3 Seed initialization */
	
	jsrseed  = (UL) time( NULL );
	
	jsr     ^= jsrseed;
	
	
}


/* --------------------------------------------------------------------------- */

void randnini(void) 
{	  
	register const double m1 = 2147483648.0, m2 = 4294967296.0 ;
	
	register double  invm1;
	
	register double dn = 3.442619855899 , dnold, tn = dn , vn = 9.91256303526217e-3 , q; 
	
	int i;
	
	
	/* Ziggurat tables for randn */	 
	
	invm1             = 1.0/m1;
	
	q                 = vn/exp(-0.5*dn*dn);  
	
	kn[0]             = (dn/q)*m1;	  
	
	kn[1]             = 0;
		  
	wn[0]             = q*invm1;	  
	
	wn[zigstep - 1]   = dn*invm1;
	
	fn[0]             = 1.0;	  
	
	fn[zigstep - 1]   = dnold = exp(-0.5*dn*dn);		
	
	for(i = (zigstep - 2) ; i >= 1 ; i--)      
	{   

		
		dn              = sqrt(-2.0*log(vn/dn + dnold));          

		
		kn[i+1]         = (dn/tn)*m1;		  
		
		tn              = dn;          
		
		fn[i]           = dnold = exp(-0.5*dn*dn);          
		
		wn[i]           = dn*invm1;      
	}
	
}


/* --------------------------------------------------------------------------- */




double nfix(void) 

{	
	const double r = 3.442620; 	/* The starting of the right tail */	
	
	static double x, y;

	
	for(;;)
		
	{
		
		x = hz*wn[iz];
		
		if(iz == 0)
			
		{	/* iz==0, handle the base strip */
			
			do
			{	
				x = -log(rand())*0.2904764;  /* .2904764 is 1/r */  
				
				y = -log(rand());			
			} 
			
			while( (y + y) < (x*x));
			
			return (hz > 0) ? (r + x) : (-r - x);	
		}
		
		if( (fn[iz] + rand()*(fn[iz-1] - fn[iz])) < ( exp(-0.5*x*x) ) ) 
			
		{
			
			return x;
			
		}
		
		
		hz = randint;		
		
		iz = (hz & (zigstep - 1));		
		
		if(abs(hz) < kn[iz]) 
			
		{
			return (hz*wn[iz]);	
			
		}
			
	}
	
}


/* --------------------------------------------------------------------------- */


double randn(void) 

{ 
	
	hz = randint;
	
	iz = (hz & (zigstep - 1));
	
	return (abs(hz) < kn[iz]) ? (hz*wn[iz]) : ( nfix() );
	
}


/* --------------------------------------------------------------------------- */
