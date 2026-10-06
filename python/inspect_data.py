import pandas as pd
from pathlib import Path

# Project paths
project_path = Path(__file__).resolve().parent.parent
data_path = project_path / "data" / "raw" / "yellow_taxi"

# Get first Parquet file
file_path = sorted(data_path.glob("*.parquet"))[0]

# Read sample data
df = pd.read_parquet(file_path)

print("\nFILE:")
print(file_path.name)

print("\nSHAPE:")
print(df.shape)

print("\nCOLUMNS:")
print(df.columns.tolist())

print("\nDATA TYPES:")
print(df.dtypes)

print("\nMISSING VALUES:")
print(df.isnull().sum())

print("\nSAMPLE DATA:")
print(df.head())