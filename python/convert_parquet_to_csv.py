import pandas as pd
from pathlib import Path


project_path = Path(__file__).resolve().parent.parent

input_path = (
    project_path
    / "data"
    / "processed"
    / "yellow_taxi"
)

output_path = (
    project_path
    / "data"
    / "sql_load"
)

output_path.mkdir(parents=True, exist_ok=True)


files = sorted(input_path.glob("*.parquet"))


for file in files:

    print(f"Converting: {file.name}")

    df = pd.read_parquet(file)

    output_file = (
        output_path
        / file.name.replace("_processed.parquet", ".csv")
    )

    df.to_csv(
        output_file,
        index=False,
        encoding="utf-8"
    )

    print(f"Created: {output_file.name}")


print("\nCSV conversion completed successfully!")