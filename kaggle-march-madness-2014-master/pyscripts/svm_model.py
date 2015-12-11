
#SVM Model

import pandas as pd
from sklearn import svm
from sklearn.svm import SVC

train = pd.read_csv('features.csv')
test = pd.read_csv('test.csv')

X_train = train.drop('target', 1)
y_train = train['target']
X_test = test.drop('target', 1)
y_test = test['target']

SVM = svm.SVC(C=1.0, class_weight=None, coef0=0.0,
    decision_function_shape= None, degree=3, gamma='auto', kernel='rbf',
    max_iter=10000, probability= True, random_state= None, shrinking= False,
    tol=0.001, verbose=False)
gaussian_model = SVM.fit(X_train,y_train)
predict_gaussian = gaussian_model.predict(X_test)
pd.DataFrame(confusion_matrix(y_test,predict_gaussian))
print "Accuracy: ",accuracy_score(y_test,predict_gaussian)
print "Mean Error Rate: ",1-accuracy_score(y_test,predict_gaussian)
