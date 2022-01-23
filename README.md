Recycling classifier.

##There is some Pre-existing work using PyTorch and this dataset https://www.kaggle.com/asdasdasasdas/garbage-classification (2400 images, 6 categories)

https://towardsdatascience.com/garbage-segregation-using-pytorch-6f2a8a67f92c
    RESNET9 manual implementation  ~83% accuracy
    
https://www.kaggle.com/aadhavvignesh/pytorch-garbage-classification-95-accuracy/notebook
    RESNET50 with last layer replaced ~95% accuracy in 355s (sagemaker ml.p2.xlarge)
    
https://rahulkaranam777.medium.com/how-to-build-a-cnn-for-classifying-garbage-using-pytorch-50510e898fc6
    RESNET50 very similar to the one above (didn't test this one myself)
    

    
##Ideas for improvement:

start with aadhavvignesh

Train faster:
* increase lr
* Transfer learning from pretrained resnet 50 rather than training the entire network

improve accuracy:
* more data - try this dataset http://web.cecs.pdx.edu/~singh/rcyc-web/dataset.html (11,500 images, 5 categories)
* different model, try Inception, like this guy https://github.com/russell-li/trash_classification_pytorch used (on a dataset that didn't look great)
* different ResNet implementation (TF?)


####  Learning Rate:
Not sure there is much potential here, lr (5.5e-5) from original work looks pretty good from the training loss plot
tried 9e-5, 15e-5 both unstable.


#### Transfer Learning:
freeze 0 layers 355s for 8 epochs - 95% accuracy after 4 epochs overfit 
Freeze first 6 layers 236s for 8 epochs - 95% accuracy after about 4 epochs.  Overfit.
freeze first 7 layers 167s for 8 epochs - 94% after 5 epochs overfit but less so.
Freeze first 9 layers (entire resnet except the last layer) - 80% accuracy in 62s (lr 7e-4)


#### Inception V3
we've added in better image resizing, so retest ResNet Now too.  And test resnet without the sigmoid.
no sigmoid, pretrained model, all layers fine tuning. 8 epochs in 471s. 92% after 4 epochs
ResNet (with better image pre-processing) with sigmoid 97% after 6 epochs (but some overfitting)
ResNet (with better image pre-processing) with sigmoid 97% after 6 epochs (but some overfitting)


#### Singh dataset
rewrote the way data was loaded so that we do augementation for the training data.  Also now with normlisation.  and no sigmoid
much bigger dataset 99% accuracy after 3 epochs.  But epochs much longer because of larger dataset 1600 s for 8 epochs
can't compare with garbage dataset because of different labels.

99% on test set

And then try training just the last 3 layers and see how much speedup we get. 99% in 3 epochs (800s per epoch)
99% in 3 epochs, 827s for 8 epochs, so not huge time saving
And then try inception - 

Why does this give improvements?
Dataset size
Quality of images
Image pre-processing

Explore

print confusion matrix