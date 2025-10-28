# Start with a standard Python 3.10 image
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /code

# Copy the requirements file and install libraries
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Copy all your app code into the container
COPY ./myenv/app.py /code/app.py
COPY ./myenv/pipeline.py /code/pipeline.py
COPY ./myenv/scrap.py /code/scrap.py
COPY ./myenv/network.py /code/network.py
COPY ./myenv/analyze.py /code/analyze.py
COPY ./myenv/templates /code/templates

# Tell the container what command to run when it starts
# We use 0.0.0.0 to allow public traffic
# We use port 7860 as that's what HF Spaces expects
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]