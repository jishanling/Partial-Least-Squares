function model = pls_train(x,y,varargin)
%{ 
% DESCRIPTION
Prediction based on Partial Least Squares (PLS) 

      model = pls_train(X,Y,varargin)

INPUT
  x            training inputs (N*d)
               N: number of samples
               d: number of features
  y            training targets (N*1)

OUTPUT
  model        PLS model

Created on 4th September 2019, by Kepeng Qiu.
-------------------------------------------------------------%
%} 

% Default Parameters setting
pve = 0.9;          % percent variance explaination

%
if rem(nargin,2)
    error('Parameters to rvm_train should be pairs')
end
numParameters = nargin/2-1;

for n =1:numParameters
    Parameters = varargin{(n-1)*2+1};
    value	= varargin{(n-1)*2+2};
    switch Parameters
            %
        case 'p'
            pve = value;
    end
end


% train pls model

%{  
PCTVAR: percentage of variance explained by the model. The first row of 
PCTVAR contains the percentage of variance explained in X by each PLS 
component, and the second row contains the percentage of variance 
explained in Y. (Please see details about PCTVAR in MATLAB help doc)  
%}  

[~,~,~,~,~,PCTVAR,~,~] = plsregress(x,y);

% PLS components
ncomp = find(cumsum(PCTVAR(2,:)) >= pve,1, 'first');

% BETA: PLS regression coefficients
[~,~,~,~,BETA,~,~,~] = plsregress(x,y,ncomp);

% PLS model
model.PCTVAR = PCTVAR;
model.ncomp = ncomp;
model.BETA = BETA;
model.pve = pve;

end
