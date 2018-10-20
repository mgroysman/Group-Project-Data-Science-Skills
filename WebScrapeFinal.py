# -*- coding: utf-8 -*-
"""
Created on Thu Oct 18 10:36:54 2018

@author: m_gro
"""

import requests
import bs4
from bs4 import BeautifulSoup
import pandas as pd
import time
import re

# cloumns for final output
columns = ['index','skill','index1','job_title', 'company_name', 'location', 'summary', 'salary']

# list where data will be stored
list1=[]

# list of skills
skills=['all','python','r','java','c','c++','HTML','CSS','Git','modeling','Machine learning','SQL','Project management','Writing','Computer science','Communication','Spark','Tableua','Hadoop','NoSQL','AWS','Deep Learning','AI','NLP','Excel','MySQL','Scala','SAS','Linux','Hive','Statistics','Visualization','Mathematics','Mining','TensorFlow','Matlab','Oracle','Julia','Cloud','Robotics','Mapreduce','Critical thinking','Teamwork','Curiosity','Business Acumen','Distributed computing','API','Mobile','Management systems','Time management','BI ','Time series','Leadership','Data analysis','Quantitative analysis','Computer vision']

# set up id for the skills
counter=0

# looping through indeed pulling skill by skill
for skill in skills:
    counter+=1
    if skill=='all':
       skill1=''  
    else:
       skill1=skill
   #if counter<2:
    # intialiazing counter of jobs for specific skill
    i=0
    # reading in indeed page
    page1 = requests.get('https://www.indeed.com/jobs?q=title%3A(data+scientist)+'+skill1+'+&limit=50')
    soup = BeautifulSoup(page1.text, 'lxml', from_encoding='utf-8')
    # getting job count for the skill
    for top in soup.find_all(name='div', attrs={'id':'searchCount'}):
        top1=int(re.sub("\D","",top.text.strip()[10:15].replace(',','')))
        # looping through the indeed pages
        for start in range(0, top1, 50):     
            page = requests.get('https://www.indeed.com/jobs?q=title%3A(data+scientist)+'+skill1+'+&limit=50&start='+str(start))
            soup = BeautifulSoup(page.text, 'lxml', from_encoding='utf-8')
            for div in soup.find_all(name='div', attrs={'class':'row'}):
                   i+=1
             #if i<2:
     
    #creating an empty list to hold the data for each posting
                job_post = [counter,skill,i]
    
    #grabbing job title
                for a in div.find_all(name='a', attrs={'data-tn-element':'jobTitle'}):
                    job_post.append(a['title']) 
    #grabbing company name
                company = div.find_all(name='span', attrs={'class':'company'}) 
                if len(company) > 0: 
                        for b in company:
                            job_post.append(b.text.strip())                             
                else:                         
                            job_post.append("NA") 
    #grabbing location name
        
                c = div.findAll('span', attrs={'class': 'location'}) 
                if len(c)>0:
                    for span in c: 
                        job_post.append(span.text) 
                else:
                    job_post.append("NA")
    #grabbing summary text
                d = div.findAll('span', attrs={'class': 'summary'}) 
                for span in d:                           
                    job_post.append(span.text.strip()) 
    #grabbing salary
                try:
                    job_post.append(div.find('nobr').text) 
                except:
                        job_post.append('Nothing_found') 
    #appending list of job post info to dataframe at index num
                list1.append(job_post)
            #sample_df.loc[num] = job_post


print(i)
df=pd.DataFrame(list1,columns=columns)
df.drop_duplicates
print(len(df.index))

#saving sample_df as a local csv file — define your own local path to save contents 
df.to_csv("C:\\Data\Skills.csv", encoding='utf-8')
