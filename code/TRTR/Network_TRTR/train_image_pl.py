import torch
import torch.nn as nn
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

# hyper-parameter
EPOCH = 40
BATCH_SIZE = 2
LR = 0.01

# DataLoader
train_dir = 'E:\\Desktop\\Code_PT\\TRTR\\Dataset_TRTR\\train'
test_dir = 'E:\\Desktop\\Code_PT\\TRTR\\Dataset_TRTR\\val'
Train_loader = DataLoader(DataFeed(train_dir,nat_sort=True),batch_size=BATCH_SIZE,shuffle=True,drop_last=True)
Test_loader = DataLoader(DataFeed(test_dir,nat_sort=True),batch_size=BATCH_SIZE,shuffle=True,drop_last=True)

# Network construction
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

def init_weights(layer):

    if type(layer) == nn.Conv2d:
        nn.init.normal_(layer.weight, mean=0, std=0.5)

    elif type(layer) == nn.Linear:
        nn.init.zeros_(layer.weight)


net = Linear_net()


print(net)

net.apply(init_weights)
lr_list = []

# Optimizer
optimizer = torch.optim.Adam(net.parameters(),lr = LR)  #Adam
scheduler = torch.optim.lr_scheduler.StepLR(optimizer,step_size=5,gamma = 1)
# Loss function
loss_func = nn.MSELoss()

# Training

train_loss = []
train_acc = []
for epoch in range(EPOCH):
    print(epoch)
    for step, (building, label) in enumerate(Train_loader):

        building = torch.reshape(building,(BATCH_SIZE,54))
        building = building.to(torch.float32)
        label = torch.squeeze(label,1)
        label = label.to(torch.float32)


        output = net(building)
        output = output.to(torch.float32)
        #print(output)
        #print(label)
        loss = loss_func(output, label)
        train_loss.append(loss.item())
        L = loss.item()
        #print(L)
        optimizer.zero_grad()
        loss = loss.to(torch.float32)
        loss.backward()
        optimizer.step()
    scheduler.step()
    lr_list.append(optimizer.state_dict()['param_groups'][0]['lr'])
plt.plot(range(len(lr_list)),lr_list,color='r')
plt.xlabel('Epoch')
plt.ylabel('Learning Rate')
plt.title('Learning Rate Curve')



plt.show()
with open("E:\\Desktop\\Code_PT\\TRTR\\Network_TRTR\\train_loss.txt", 'w') as train_los:
    train_los.write(str(train_loss))

def data_read(dir_path):
    with open(dir_path, "r") as f:
        raw_data = f.read()
        data = raw_data[1:-1].split(", ")

    return np.asfarray(data, float)

# 画loss曲线
train_loss_path = r"E:\\Desktop\\Code_PT\\TRTR\\Network_TRTR\\train_loss.txt"
y_train_loss = data_read(train_loss_path)
x_train_loss = range(len(y_train_loss))
plt.figure()

ax = plt.axes()
ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)
plt.xlabel('Iterations')
plt.ylabel('Loss')

plt.plot(x_train_loss, y_train_loss, linewidth=1, linestyle="solid", label="train loss")
plt.legend()
plt.title('Loss Curve')
plt.show()

torch.save(net.state_dict(), 'mlp_TRTR_0309.params')


