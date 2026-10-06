import pandas as pd
from pathlib import Path


# --------------------------------------------------
# Project Paths
# --------------------------------------------------

project_path = Path(__file__).resolve().parent.parent

processed_path = (
    project_path
    / "data"
    / "processed"
    / "yellow_taxi"
)

files = sorted(processed_path.glob("*.parquet"))


# --------------------------------------------------
# Quality Thresholds
# --------------------------------------------------
# These are only used for profiling and flagging.
# No records will be deleted.

EXTREME_DISTANCE_MILES = 100
EXTREME_DURATION_MINUTES = 240
EXTREME_AMOUNT = 500


# --------------------------------------------------
# Store Summary Results
# --------------------------------------------------

summary = []


# --------------------------------------------------
# Process Each File
# --------------------------------------------------

for file in files:

    print(f"Processing summary: {file.name}")

    df = pd.read_parquet(file)

    total_trips = len(df)

    zero_distance = (df["trip_distance"] == 0).sum()

    negative_amount = (df["total_amount"] < 0).sum()

    zero_amount = (df["total_amount"] == 0).sum()

    extreme_distance = (
        df["trip_distance"] > EXTREME_DISTANCE_MILES
    ).sum()

    extreme_duration = (
        df["trip_duration_minutes"]
        > EXTREME_DURATION_MINUTES
    ).sum()

    extreme_amount = (
        df["total_amount"] > EXTREME_AMOUNT
    ).sum()

    summary.append(
        {
            "file": file.name,
            "total_trips": total_trips,
            "zero_distance_trips": zero_distance,
            "negative_amount_records": negative_amount,
            "zero_amount_records": zero_amount,
            "extreme_distance_records": extreme_distance,
            "extreme_duration_records": extreme_duration,
            "extreme_amount_records": extreme_amount
        }
    )


# --------------------------------------------------
# Create Summary DataFrame
# --------------------------------------------------

summary_df = pd.DataFrame(summary)


# --------------------------------------------------
# Display Summary
# --------------------------------------------------

print("\n" + "=" * 100)
print("SMART CITY MOBILITY DATA QUALITY SUMMARY")
print("=" * 100)

print(summary_df.to_string(index=False))


# --------------------------------------------------
# Save Summary
# --------------------------------------------------

output_path = (
    project_path
    / "data"
    / "processed"
    / "data_quality_summary.csv"
)

summary_df.to_csv(output_path, index=False)

print("\nSummary saved successfully!")

print(f"Location: {output_path}")

print("\n" + "=" * 100)
print("DATA QUALITY SUMMARY COMPLETED SUCCESSFULLY!")
print("=" * 100)