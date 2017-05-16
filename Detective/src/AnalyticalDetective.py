# -*- coding: utf-8 -*-
"""
Éditeur de Spyder

Ceci est un script temporaire.
"""
import pandas as pd

datafile = "../data/mvtWeek1.csv"
mvt = pd.read_csv(datafile)
df = pd.DataFrame(mvt)

print(df.head())
print(df.tail())
print(df.describe())
print(df.columns)