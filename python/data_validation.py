import pandas as pd
from pathlib import Path

# --------------------------------------------------
# Project Paths
# --------------------------------------------------

project_path = Path(__file__).resolve().parent.parent

processed_path = (
    project_path /
    "data" /
    "processed" /
    "yellow_taxi"
)

files = sorted(processed_path.glob("*.parquet"))

# --------------------------------------------------
# Validate Each File
# --------------------------------------------------

for file in files:

    print("\n" + "=" * 60)
    print(f"VALIDATING: {file.name}")
    print("=" * 60)

    df = pd.read_parquet(file)

    # Basic information
    print(f"\nTotal Rows: {len(df):,}")

    # Missing critical values
    critical_columns = [
        "tpep_pickup_datetime",
        "tpep_dropoff_datetime",
        "PULocationID",
        "DOLocationID",
        "trip_duration_minutes"
    ]

    print("\nMissing Critical Values:")

    for column in critical_columns:
        missing_count = df[column].isna().sum()
        print(f"{column}: {missing_count:,}")

    # Invalid values
    invalid_duration = (
        df["trip_duration_minutes"] <= 0
    ).sum()

    invalid_distance = (
        df["trip_distance"] <= 0
    ).sum()

    invalid_total_amount = (
        df["total_amount"] <= 0
    ).sum()

    print("\nInvalid Records:")

    print(
        f"Trip Duration <= 0: "
        f"{invalid_duration:,}"
    )

    print(
        f"Trip Distance <= 0: "
        f"{invalid_distance:,}"
    )

    print(
        f"Total Amount <= 0: "
        f"{invalid_total_amount:,}"
    )

    # Trip statistics
    print("\nTrip Statistics:")

    print(
        df[
            [
                "trip_distance",
                "trip_duration_minutes",
                "total_amount"
            ]
        ].describe()
    )

print("\n" + "=" * 60)
print("DATA VALIDATION COMPLETED SUCCESSFULLY!")
print("=" * 60)