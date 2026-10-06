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
# Profile Each File
# --------------------------------------------------

for file in files:

    print("\n" + "=" * 70)
    print(f"DATA QUALITY PROFILE: {file.name}")
    print("=" * 70)

    df = pd.read_parquet(file)

    # --------------------------------------------------
    # Trip Distance
    # --------------------------------------------------

    distance = df["trip_distance"]

    print("\nTRIP DISTANCE")

    print(f"Negative: {(distance < 0).sum():,}")
    print(f"Zero: {(distance == 0).sum():,}")

    print(f"P95: {distance.quantile(0.95):,.2f}")
    print(f"P99: {distance.quantile(0.99):,.2f}")
    print(f"P99.9: {distance.quantile(0.999):,.2f}")

    print(f"Maximum: {distance.max():,.2f}")


    # --------------------------------------------------
    # Trip Duration
    # --------------------------------------------------

    duration = df["trip_duration_minutes"]

    print("\nTRIP DURATION (MINUTES)")

    print(f"Minimum: {duration.min():,.2f}")
    print(f"P95: {duration.quantile(0.95):,.2f}")
    print(f"P99: {duration.quantile(0.99):,.2f}")
    print(f"P99.9: {duration.quantile(0.999):,.2f}")

    print(f"Maximum: {duration.max():,.2f}")


    # --------------------------------------------------
    # Total Amount
    # --------------------------------------------------

    amount = df["total_amount"]

    print("\nTOTAL AMOUNT")

    print(f"Negative: {(amount < 0).sum():,}")
    print(f"Zero: {(amount == 0).sum():,}")

    print(f"P95: {amount.quantile(0.95):,.2f}")
    print(f"P99: {amount.quantile(0.99):,.2f}")
    print(f"P99.9: {amount.quantile(0.999):,.2f}")

    print(f"Maximum: {amount.max():,.2f}")


print("\n" + "=" * 70)
print("DATA QUALITY PROFILING COMPLETED SUCCESSFULLY!")
print("=" * 70)