# Fraud lab dataset

The notebook `04-credit-card-fraud-detection-decision-trees-svm.ipynb` needs
`creditcard.csv` in this directory. Git omits the file because it is about
151 MB, above GitHub's regular file limit.

1. Download the **Credit Card Fraud Detection** dataset from
   [the dataset page on Kaggle](https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud).
2. Extract `creditcard.csv` into this directory. Keep that exact filename.
3. From PowerShell in this directory, check the file:

   ```powershell
   (Get-Item .\creditcard.csv).Length
   (Get-FileHash .\creditcard.csv -Algorithm SHA256).Hash
   ```

The copy used to execute the notebook had **150828752 bytes** and SHA-256
`76274B691B16A6C49D3F159C883398E03CCD6D1EE12D9D8EE38F4B4B98551A89`.
If Kaggle updates the dataset, its checksum may differ; inspect the CSV's
columns (`Time`, `V1`–`V28`, `Amount`, `Class`) before running the lab.

The repository's `.gitignore` keeps `creditcard.csv` out of commits.
