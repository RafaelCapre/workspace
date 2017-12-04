from datetime import datetime, timedelta

print(datetime.now())

periodo = timedelta(
                    days=7, 
                    seconds=0, 
                    microseconds=0, 
                    milliseconds=0, 
                    minutes=0, 
                    hours=0, 
                    weeks=0)

print(periodo)

print(datetime.now()+periodo)

print(datetime.now().strftime("%d/%m/%y"))
#pegar referencia na internet, sobre o formato.

#string to date
data = "jun 1 2005"
#print (datetime.strptime(data,"%b %d %" ))


data1 = datetime.now()
data2 = datetime.now() + periodo

if data1 < data2:
    print("data 1 menor")