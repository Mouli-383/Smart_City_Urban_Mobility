from pathlib import Path
import pandas as pd


# ============================================================
# SMART CITY URBAN MOBILITY INTELLIGENCE
# SPLIT LARGE CSV FILES FOR SNOWFLAKE UPLOAD
# ============================================================


# ------------------------------------------------------------
# 1. PROJECT PATH CONFIGURATION
# ------------------------------------------------------------

# Get the current script location:
# Smart_City_Urban_Mobility_Intelligence/python/
SCRIPT_DIR = Path(__file__).resolve().parent

# Move one level up to the project root:
# Smart_City_Urban_Mobility_Intelligence/
PROJECT_ROOT = SCRIPT_DIR.parent

# Input folder containing large CSV files
INPUT_FOLDER = PROJECT_ROOT / "data" / "sql_load"

# Output folder containing Snowflake-ready split CSV files
OUTPUT_FOLDER = PROJECT_ROOT / "data" / "snowflake_upload"


# ------------------------------------------------------------
# 2. CONFIGURATION
# ------------------------------------------------------------

# Number of rows per output CSV chunk
# You can adjust this if required
ROWS_PER_CHUNK = 1300_000


# ------------------------------------------------------------
# 3. CREATE OUTPUT DIRECTORY
# ------------------------------------------------------------

OUTPUT_FOLDER.mkdir(parents=True, exist_ok=True)


# ------------------------------------------------------------
# 4. DISPLAY PATH INFORMATION
# ------------------------------------------------------------

print("=" * 70)
print("SMART CITY URBAN MOBILITY INTELLIGENCE")
print("CSV SPLITTING FOR SNOWFLAKE UPLOAD")
print("=" * 70)

print(f"\nProject Root:")
print(PROJECT_ROOT)

print(f"\nInput Folder:")
print(INPUT_FOLDER)

print(f"\nOutput Folder:")
print(OUTPUT_FOLDER)


# ------------------------------------------------------------
# 5. VALIDATE INPUT FOLDER
# ------------------------------------------------------------

if not INPUT_FOLDER.exists():
    raise FileNotFoundError(
        f"\nERROR: Input folder does not exist:\n{INPUT_FOLDER}"
    )


# ------------------------------------------------------------
# 6. FIND ALL CSV FILES
# ------------------------------------------------------------

csv_files = sorted(INPUT_FOLDER.glob("*.csv"))

if not csv_files:
    raise FileNotFoundError(
        f"\nERROR: No CSV files found in:\n{INPUT_FOLDER}"
    )


print("\n" + "=" * 70)
print(f"FOUND {len(csv_files)} CSV FILE(S)")
print("=" * 70)

for csv_file in csv_files:
    file_size_mb = csv_file.stat().st_size / (1024 * 1024)

    print(f"\nFile: {csv_file.name}")
    print(f"Size: {file_size_mb:.2f} MB")


# ------------------------------------------------------------
# 7. SPLIT EACH CSV FILE
# ------------------------------------------------------------

print("\n" + "=" * 70)
print("STARTING CSV SPLITTING PROCESS")
print("=" * 70)


for csv_file in csv_files:

    print("\n" + "-" * 70)
    print(f"Processing: {csv_file.name}")
    print("-" * 70)

    chunk_number = 1
    total_rows = 0

    try:

        # Read the CSV file in chunks
        for chunk in pd.read_csv(
            csv_file,
            chunksize=ROWS_PER_CHUNK,
            low_memory=False
        ):

            # Create output filename
            output_file = (
                OUTPUT_FOLDER
                / f"{csv_file.stem}_part_{chunk_number}.csv"
            )

            # Save chunk as CSV
            chunk.to_csv(
                output_file,
                index=False
            )

            # Calculate output file size
            file_size_mb = (
                output_file.stat().st_size
                / (1024 * 1024)
            )

            # Update total rows
            total_rows += len(chunk)

            print(f"\nCreated: {output_file.name}")
            print(f"Rows: {len(chunk):,}")
            print(f"Size: {file_size_mb:.2f} MB")

            chunk_number += 1


        print("\n✓ FILE PROCESSING COMPLETED")
        print(f"Original File: {csv_file.name}")
        print(f"Total Rows: {total_rows:,}")
        print(f"Total Parts Created: {chunk_number - 1}")


    except Exception as error:

        print("\n✗ ERROR WHILE PROCESSING FILE")
        print(f"File: {csv_file.name}")
        print(f"Error: {error}")


# ------------------------------------------------------------
# 8. FINAL SUMMARY
# ------------------------------------------------------------

output_files = sorted(OUTPUT_FOLDER.glob("*.csv"))

print("\n" + "=" * 70)
print("CSV SPLITTING COMPLETED SUCCESSFULLY")
print("=" * 70)

print(f"\nTotal Output Files: {len(output_files)}")

print("\nOutput Files:")

for output_file in output_files:

    file_size_mb = (
        output_file.stat().st_size
        / (1024 * 1024)
    )

    print(
        f"\n{output_file.name}"
        f"\nSize: {file_size_mb:.2f} MB"
    )


print("\n" + "=" * 70)
print("ALL FILES ARE READY FOR SNOWFLAKE UPLOAD")
print("=" * 70)