'''
A data feeding class. It generates a list of data samples, each of which is
a tuple of a string (image path) and a float (future location), and it defines
a data-fetching method.
'''
import os
import torch
from natsort import natsorted
import random
from skimage import io
from torch.utils.data import Dataset, DataLoader
import scipy.io as sciio
import torchvision.transforms as transf
import numpy as np



################## Creating data samples ####################
def create_samples(root,shuffle,nat_sort = False): #?????????????????????????True or False
    init_names = os.listdir(root) # List all sub-directories in root
    if nat_sort:
        sub_dir_names = natsorted(init_names) # sort directory names in natural order
                                              # (Only for directories with numbers for names)
    else:
        sub_dir_names = init_names
    data_samples = []
    for sub_dir in sub_dir_names: # Loop over all sub-directories
        per_dir = os.listdir(root+'/'+sub_dir) # Get a list of names from sub-dir # i
        if per_dir: # If img_per_dir is NOT empty
            building_list = []
            pl_label_list = []
            dir_count = 0
            for name in per_dir:
                dir_count += 1
                split_name = name.split('_')
                if split_name[0]=='input':
                    building_list.append(root + '/' + sub_dir + '/' + str(name))
                elif split_name[0]=='label':
                    pl_label_list.append(root + '/' + sub_dir + '/' + str(name))
            sample = (building_list,pl_label_list)
            data_samples.append(sample)
    if shuffle:
        random.shuffle(data_samples)

    return data_samples #???????????????????????????????是路径


#############################################################

class DataFeed(Dataset):
    '''
    A class retrieving a tuple of (image,label). It can handle the case
    of empty classes (empty folders).
    '''
    def __init__(self,root_dir, nat_sort = False, init_shuflle = False):
        self.root = root_dir
        self.samples = create_samples(self.root,shuffle=init_shuflle,nat_sort=nat_sort)

    def __len__(self):
        return len( self.samples )

    def __getitem__(self, idx):
        sample = self.samples[idx]
        building_list = sample[0]
        for i in building_list:
            split_i = i.split('/')
            split_i = split_i[2]
            split_i = split_i.split('.')
            split_i = split_i[0]
            building = sciio.loadmat(i)[split_i]
            building = torch.as_tensor(building)
        label_list = sample[1]
        for j in label_list:
            split_j = j.split('/')
            split_j = split_j[2]
            split_j = split_j.split('.')
            split_j = split_j[0]
            label = sciio.loadmat(j)[split_j]
            label = torch.as_tensor(label)
        return (building,label)
