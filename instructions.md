# Instructions

## Backend

### 1. Activate virtual environment

If you have the virtual environment folder already created:

```bash
source env/bin/activate    # where 'env' is the folder of your virtualenv
```

If you don't have any virtual environment created:

```bash
cd <repository root>         # go to project's main folder
pip3 install virtualenv      # install virtualenv package
python3 -m virtualenv env    # create virtualenv at folder env
source env/bin/activate      # activate the virtualenv
```

If your terminal now has a `(env)` prefix, you have successfully activated the virtual environment.

### 2. Install needed dependencies

```bash
pip install -r requirements.txt
```

> It's okay to install even if you have already installed them

### 3. Run the project

```bash
cd backend                    # go to backend directory
python manage.py runserver    # run the backend server
```
