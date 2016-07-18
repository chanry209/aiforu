#include "mex.h"
#include "math.h"
#include "stdlib.h"

#define INITDELTA 16
#define ITER 3
#define ALPHA 0.03
#define ALPHA2 0.002

void recal(double *image,double **newimage,int mrows, int ncols, int *bounds, double *transform, int ntransform);
void findbestcorr(double **newimage, int ncols, int *bounds, int n, double *origvec,int morigvec,double *transform, int ntransform,int iter);
void transformvec(double *origvec, int n, double *&tvec, int boundsvec[2], double *transform, int ntransform);
double cost(double **image,double *vec, int *bounds, int vecbounds[2], int ncols, int n);
double costd(double *transform, int ncols,int ntransform,int n,int iter);
double correlation(double *a, double* b, int n);
int * rpermute(int n);


//*************************************************************************
void mexFunction(int nlhs, mxArray *plhs[], int nrhs,
        const mxArray *prhs[]) {
    
    int mrows, ncols;
    double *image;
    double **newimage;
    double *outputimage;
    double *transform;
    double *finalbounds;
    int *bounds;
    int ntransform;
    int i,j,s;
    
    //srand (time(NULL));
    
    /* Check for proper number of arguments. */
    if (nrhs != 1 && nrhs != 2) {
        mexErrMsgTxt("1 or 2 input required.");
    } else if (nlhs > 3) {
        mexErrMsgTxt("Too many output arguments");
    }
    
    
    
    mrows = (int) mxGetM(prhs[0]);
    ncols = (int) mxGetN(prhs[0]);    
    if (nrhs == 1)
        ntransform=1;
    else
        ntransform = (int) mxGetScalar(prhs[1]);
    
    if ( mxIsComplex(prhs[0]) || !mxIsDouble(prhs[0])) {
        mexErrMsgTxt("Input 1 must be a noncomplex double matrix.");
    }
    
    image = mxGetPr(prhs[0]);
    

    if(nlhs >= 2) {
        plhs[1] = mxCreateDoubleMatrix(ntransform, ncols, mxREAL);
        transform=mxGetPr(plhs[1]);
    }
    else
        transform=mxGetPr(mxCreateDoubleMatrix(ntransform, ncols, mxREAL));
    
    if(nlhs >= 3) {
        plhs[2] = mxCreateDoubleMatrix(1, 2, mxREAL);
        finalbounds=mxGetPr(plhs[2]);
    }
    else
        finalbounds=mxGetPr(mxCreateDoubleMatrix(1, 2, mxREAL));
    
    
    newimage=(double **) malloc(ncols*sizeof(double*));
    bounds=(int *) malloc(ncols*2*sizeof(int));
    for(i=0;i<ncols;i++) {
        newimage[i]=(double *) malloc(mrows*sizeof(double*));
        for(j=0;j<mrows;j++) {
            newimage[i][j]=image[i*mrows+j];
        }
        bounds[2*i]=0;
        bounds[2*i+1]=mrows;
    }
    /*int b[2];
    b[0]=-8;
    b[1]=492-8;
    bounds[10]=-16;
    bounds[11]=492-16;
    double cc=cost(newimage,newimage[50], bounds, b, ncols, 50);
    mexPrintf("C : %lf \n", cc);*/
    //findbestcorr(newimage, ncols, bounds, 80, newimage[80],mrows,transform+80, ntransform);
    //mexPrintf("C : %lf \n", transform[80*ntransform]);
    recal(image, newimage, mrows, ncols,  bounds, transform, ntransform);

    finalbounds[1]=mrows;
    for(i=0;i<ncols;i++) {
        if(bounds[2*i]>finalbounds[0])
            finalbounds[0]=bounds[2*i];
        if(bounds[2*i+1]<finalbounds[1])
            finalbounds[1]=bounds[2*i+1];
    }
    s=(int) (finalbounds[1]-finalbounds[0]);
    plhs[0] = mxCreateDoubleMatrix(s, ncols, mxREAL);
    outputimage=mxGetPr(plhs[0]);    
    for(i=0;i<ncols;i++) {
        for(j=(int) finalbounds[0];j<finalbounds[1];j++) {
            outputimage[(int) (i*s+j-finalbounds[0])]=newimage[i][j-bounds[2*i]];
        }
        free(newimage[i]);
    }
    finalbounds[1]++;
    finalbounds[0]++;
    
    free(newimage);
    free(bounds);
}

//*************************************************************************
void recal(double *image,double **newimage,int mrows, int ncols, int *bounds, double *transform, int ntransform) {
    int i, j;
    int *order=NULL;
   
    for(i=0;i<ITER;i++) {
        order=rpermute(ncols);
        for(j=0;j<ncols;j++) {
            //mexPrintf("I:%d - Optimisation de %d\n",i, order[j]);
            findbestcorr(newimage, ncols, bounds, order[j], image+mrows*order[j], mrows,transform, ntransform,i);
            //mexPrintf("new T : %lf\n",transform[order[j]]);
        }
        free(order);
    }
}
//*************************************************************************
void findbestcorr(double **newimage, int ncols, int *bounds, int n, double *origvec,int morigvec,double *transform, int ntransform,int iter) {
    double *tvec=NULL;
    double *t=transform+n*ntransform;
    int boundsvec[2];
    double score;
    double delta=INITDELTA;
    int i;
    int precibest=-1;
    double *newscore=(double *) malloc(2*ntransform*sizeof(double));
    int ibestscore;

    score=cost(newimage,newimage[n],bounds,bounds+2*n, ncols, n)-costd(transform,ncols,ntransform,n,iter);
    //mexPrintf("score original: %lf pour %d t:%lf costd:%lf\n",score,n,t[0],costd(transform,ncols,ntransform,n,iter));
    while(delta>=1) {
        //mexPrintf("Delta : %f \n",delta);
        ibestscore=-1;
        for(i=0;i<ntransform;i++) {
            if(precibest!=2*i+1) {
                t[i]+=delta;
                 //mexPrintf("before ==");
                transformvec(origvec,morigvec,tvec,boundsvec,t,ntransform);
                //mexPrintf(" ==after t1:%lf b1:%d b2:%d t:%lf\n",tvec[0],boundsvec[0],boundsvec[1],transform[i]);
                newscore[2*i]=cost(newimage,tvec,bounds,boundsvec, ncols, n)-costd(transform,ncols,ntransform,n,iter);
                if(newscore[2*i]>score) {
                    score=newscore[2*i];
                    ibestscore=2*i;
                }
                t[i]-=delta;
            }
            //mexPrintf("score : %f i:%d bi:%d :\n",newscore[2*i],i,ibestscore);           
            if(precibest!=2*i) {
                t[i]-=delta;
                //mexPrintf("before ==");
                transformvec(origvec,morigvec,tvec,boundsvec,t,ntransform);
                //mexPrintf(" ==after t1:%lf b1:%d b2:%d t:%lf\n",tvec[0],boundsvec[0],boundsvec[1],transform[i]);

                newscore[2*i+1]=cost(newimage,tvec,bounds,boundsvec, ncols, n)-costd(transform,ncols,ntransform,n,iter);  
                if(newscore[2*i+1]>score) {
                    score=newscore[2*i+1];
                    ibestscore=2*i+1;
                } 
                //mexPrintf("score : %f i:%d bi:%d :\n",newscore[2*i+1],i,ibestscore);           
                t[i]+=delta;
            }
        }
        if(ibestscore==-1)
            delta=0.5*delta;
        else{
            if(ibestscore%2==0)
                t[ibestscore/2]+=delta;
            else
                t[ibestscore/2]-=delta;        
        }
        precibest=ibestscore;
        
    }
    //mexPrintf("score final: %lf t:%lf costd:%lf\n",score,t[0],costd(transform,ncols,ntransform,n,iter));
    free(newscore);
    transformvec(origvec, morigvec, tvec, boundsvec, t, ntransform);

    
    free(newimage[n]);
    newimage[n]=tvec;
    bounds[2*n]=boundsvec[0];
    bounds[2*n+1]=boundsvec[1];
}
//*************************************************************************
void transformvec(double *origvec, int n, double *&tvec, int boundsvec[2], double *transform, int ntransform){
    int i;
    if(tvec!=NULL)
        free(tvec);
    tvec=(double *) malloc(n*sizeof(double));
    for(i=0;i<n;i++)
        tvec[i]=origvec[i];
    //tvec=origvec;
    boundsvec[0]=(int) (transform[0]);
    boundsvec[1]=(int) (n+transform[0]);
}
//*************************************************************************
double cost(double **image,double *vec, int *bounds, int vecbounds[2], int ncols, int n) {
    int i;

    int ba=vecbounds[0];
    int fa=vecbounds[1];    
    int bb,fb,deb,fin;    
    double s=0;
        
    for(i=0;i<ncols;i++) {
        if(i!=n) {
            bb=bounds[2*i];
            fb=bounds[2*i+1];
            deb=(ba>bb?ba:bb);
            fin=(fa<fb?fa:fb);
            s+=correlation(vec+deb-ba, image[i]+deb-bb, fin-deb);
        }
    }
    return s/ncols;
}
//*************************************************************************
double costd(double *transform, int ncols,int ntransform,int n,int iter) {

    double center;
    double c1,c2;

    if(n==0)
        center=transform[ntransform];
    else if(n==ncols-1)
        center=transform[(ncols-2)*ntransform];   
    else
        center=0.5*(transform[(n+1)*ntransform]+transform[(n-1)*ntransform]);  
    c1=iter*fabs(transform[n*ntransform]-center)/ITER;
    c2=fabs(transform[n*ntransform]);//*(ncols-fabs(n-.5*ncols))/ncols;
    return c1*ALPHA+c2*ALPHA2;
    
}
//*************************************************************************
double correlation(double *a, double* b, int n) {
    double m1a=0,m1b=0,m2a=0,m2b=0,mab=0,invn=1./n;
    double ai,bi;
    int i;
    for (i=0;i<n;i++) {
        ai=a[i];bi=b[i];
        m1a+=ai;
        m1b+=bi;
        m2a+=ai*ai;
        m2b+=bi*bi;
        mab+=ai*bi;
    }
    
    m1a*=invn;m1b*=invn;
    m2a*=invn;m2b*=invn;
    mab*=invn;

    
    mab-=m1a*m1b;
    m2a-=m1a*m1a;
    m2b-=m1b*m1b;

    return mab*mab/(m2a*m2b);
}


//*************************************************************************
int * rpermute(int n) {
    int *a = (int *) malloc(n*sizeof(int));
    int k,j,temp;
    for (k = 0; k < n; k++)
        a[k] = k;
    
    for (k =0 ; k<n; k++) {
        j = rand() % n;
        temp = a[j];
        a[j] = a[k];
        a[k] = temp;
    }
    return a;
}