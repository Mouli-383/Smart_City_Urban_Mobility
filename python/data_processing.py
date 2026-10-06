import pandas as pd
from pathlib import Path

# --------------------------------------------------
# Project Paths
# --------------------------------------------------

project_path = Path(__file__).resolve().parent.parent

raw_path = project_path / "data" / "raw" / "yellow_taxi"
processed_path = project_path / "data" / "processed" / "yellow_taxi"

processed_path.mkdir(parents=True, exist_ok=True)


# --------------------------------------------------
# Required Columns
# --------------------------------------------------

required_columns = [
    "VendorID",
    "tpep_pickup_datetime",
    "tpep_dropoff_datetime",
    "passenger_count",
    "trip_distance",
    "RatecodeID",
    "PULocationID",
    "DOLocationID",
    "payment_type",
    "fare_amount",
    "extra",
    "mta_tax",
    "tip_amount",
    "tolls_amount",
    "improvement_surcharge",
    "total_amount",
    "congestion_surcharge",
    "Airport_fee",
    "cbd_congestion_fee"
]


# --------------------------------------------------
# Process Each File
# --------------------------------------------------

files = sorted(raw_path.glob("*.parquet"))

for file in files:

    print(f"\nProcessing: {file.name}")

    # Read raw data
    df = pd.read_parquet(file)

    original_rows = len(df)

    # Check required columns
    missing_columns = [
        column
        for column in required_columns
        if column not in df.columns
    ]

    if missing_columns:
        print(f"Skipping {file.name}")
        print("Missing columns:", missing_columns)
        continue

    # Keep only required columns
    df = df[required_columns]

    # Remove rows with missing critical values
    df = df.dropna(
        subset=[
            "tpep_pickup_datetime",
            "tpep_dropoff_datetime",
            "PULocationID",
            "DOLocationID"
        ]
    )

    # Remove invalid timestamps
    df = df[
        df["tpep_dropoff_datetime"] >
        df["tpep_pickup_datetime"]
    ]

    # Create trip duration
    df["trip_duration_minutes"] = (
        df["tpep_dropoff_datetime"] -
        df["tpep_pickup_datetime"]
    ).dt.total_seconds() / 60

    # Create basic time columns
    df["trip_date"] = df["tpep_pickup_datetime"].dt.date

    df["pickup_hour"] = (
        df["tpep_pickup_datetime"].dt.hour
    )

    # Create output filename
    output_file = (
        processed_path /
        f"{file.stem}_processed.parquet"
    )

    # Save processed data
    df.to_parquet(
        output_file,
        index=False
    )

    # Print processing summary
    final_rows = len(df)

    print(f"Original Rows: {original_rows:,}")
    print(f"Processed Rows: {final_rows:,}")
    print(f"Removed Rows: {original_rows - final_rows:,}")
    print(f"Saved: {output_file.name}")


print("\nAll files processed successfully!")