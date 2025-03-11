import torch
import torch.nn as nn
import math
from torch.autograd import Variable
import torch.utils.data as Data
from torchvision import datasets, transforms
import matplotlib.pyplot as plt
import scipy.io as sciio
from torchsummary import summary
import time
import numpy as np
from torch.utils.data import DataLoader
from data_feed_Sequence_new2 import DataFeed

dropout1 = 0.22
dropout2 = 0.22
dropout3 = 0.22

class Linear_net(nn.Module):
    def __init__(self):
        super(Linear_net, self).__init__()
        self.layer = nn.Sequential(
            nn.Flatten(),
            nn.Linear(54, 32),
            nn.ReLU(),
            nn.Dropout(dropout1),
            nn.Linear(32, 16),
            nn.ReLU(),
            nn.Dropout(dropout2),
            nn.Linear(16, 8),
            nn.ReLU(),
            nn.Dropout(dropout3),
        )
        self.output_layer = nn.Linear(8, 1)
    def forward(self, x):
        x = self.layer(x)
        x = x.reshape(x.size(0), -1)
        output = self.output_layer(x)
        return output

test_dir = 'E:\\Desktop\\Code_PT\\TRTR\\Dataset_TRTR\\test'
BATCH_SIZE = 1
Test_loader = DataLoader(DataFeed(test_dir,nat_sort=True),batch_size=BATCH_SIZE,shuffle=False,drop_last=True)
clone = Linear_net()
clone.load_state_dict(torch.load('mlp_TRTR_0309.params'))
clone.eval()
loss_func = nn.L1Loss()

print('start test')
total_loss = 0
total_error = 0
total_label = 0
total_output = 0
n = 0
with torch.no_grad():
    clone.eval()
    print(clone)
for step, (building, label) in enumerate(Test_loader):

    print(step)
    temp = step + 1
    n = n+1
    building = torch.reshape(building, (BATCH_SIZE, 54))
    building = building.to(torch.float32)
    label = torch.squeeze(label, 1)

    output = clone(building)
    print(output)
    '''inputpath = 'E:\Desktop\Image_pl_Scenario_WI\input_test\input_test' + str(temp) + '.mat'
    inputmat = building.tolist()
    sciio.savemat(inputpath, {'input_test' + str(temp): inputmat})'''
    label_path = 'E:\\Desktop\\Code_PT\\TRTR\\Network_TRTR\\test_label'
    output_path = 'E:\\Desktop\\Code_PT\\TRTR\\Network_TRTR\\test_output'
    labelpath = label_path + '\\label_test'+ str(temp) +'.mat'
    outputpath = output_path + '\\output_test'+ str(temp) +'.mat'
    labelmat = label.tolist()
    outputmat = output.tolist()
    sciio.savemat(labelpath, {'label_test':labelmat})
    sciio.savemat(outputpath,{'output_test':outputmat})

    loss = loss_func(output, label)
    total_loss = total_loss + loss
    total_label = total_label + label
    total_output = total_output + output
    error = abs(output-label)/label
    errorpath = 'E:\\Desktop\\Code_PT\\TRTR\\Network_TRTR\\error'
    error_path = errorpath + '\\error'+str(temp)+'.mat'
    errormat = error.tolist()
    sciio.savemat(error_path, {'error': errormat})
    total_error = total_error + error
    print(error)

    print(loss)


print(n)
print("RMSE = %.4f dB" %(math.sqrt(total_loss/176)))
print('average output = %.4f dB' %((total_output)/176))
print('average label = %.4f dB' %((total_label)/176))
print('average error = %.4f' %((total_error)/176))