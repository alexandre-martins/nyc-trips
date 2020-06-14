# NYC Taxi Trips

This project is an analysis of the New York City 
taxi trips dataset. 

The data is comprised of:

#### Trips data

- sample_data-nyctaxi-trips-2009-json_corrigido.json
- sample_data-nyctaxi-trips-2010-json_corrigido.json
- sample_data-nyctaxi-trips-2011-json_corrigido.json
- sample_data-nyctaxi-trips-2012-json_corrigido.json

#### Vendors data

- data-vendor_lookup-csv.csv

#### Payments lookup data

- data-payment_lookup-csv.csv

The focus of the project is to do an exploratory
analysis and to answer some questions that can be
verified in the main notebook file.

## Usage

To reproduce the analysis you will have to clone this repository.

Create a python 3 environment, preferably with [conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/)
```
conda create -n ENV_NAME python=3.7
```
This projects uses Spark. So, before installing it,
you have to install Java 8. On Linux, it can be done
with
```
sudo apt install openjdk-8-jre-headless
sudo apt install openjdk-8-jdk
```

Install the project requirements
```
pip install -r requirements.txt
```

### Running

This project runs on jupyter notebooks. Therefore, running it is
simply opening the jupyter UI and then the notebook

```
jupyter notebook
```

Alternatively, you can have access to the analysis and conclusions
in the Analysis.html file.


