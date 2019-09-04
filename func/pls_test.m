function yfit = pls_test(model,xt)
%{
DESCRIPTION
Prediction based on Partial Least Squares (PLS) 

      yfit = rvm_test(model,X)

INPUT
  Xt            testing inputs (N*d)
                N: number of samples
                d: number of features
  model         PLS model

OUTPUT
  yfit         prediction


Created on 4th September 2019, by Kepeng Qiu.
-------------------------------------------------------------%
%}

% prediction
yfit = [ones(size(xt,1),1) xt]*model.BETA;

end