import serial
import mysql.connector
import datetime

ID_SENSORE_TEMPERATURA = 1
ID_SENSORE_UMIDITA = 2
ID_SENSORE_PRESSIONE = 3 

def saveData(id_stazione, value, voltaggioBatteria, id_sensore):
    try:
        link = mysql.connector.connect(user='remote', password='', host='192.168.43.116', database='data_logger_db')
    except mysql.connector.Error:
        print("Impossibile connettersi al database")

    currentDateTime = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    sql = "INSERT INTO valore (Valore,Data_Ora,VoltaggioBatteria,IdSensore,IdStazione) VALUES (%s,%s,%s,%s,%s);"
    data = (value, currentDateTime, voltaggioBatteria, id_sensore, id_stazione)

    try:
        crx = link.cursor()
        crx.execute(sql, data)
        print('query eseguita')

        crx.close()
        link.close()
    except:
        print('query non eseguita')

try:
    #apro il collegamento con la porta serial a 57600 di baundrate
    with serial.Serial('/dev/cu.SLAB_USBtoUART', 57600) as ser:
        while True:
            #leggo riga per riga di quello che viene inviato sulla seriale
            #e la formatto come stringa, senza caratteri extra
            line = ser.readline()
            values = line.decode().strip()

            #converto i valori da string a float in modo che
            #possano essere inseriti nel db correttamente
            id_stazione = int(values.split(',')[0])
            temp = float(values.split(',')[1])
            press = float(values.split(',')[2])
            hum = float(values.split(',')[3])

            #!mantenere così fino a quando non avrò trovato un modo per ricavare il voltaggio della batteria tramite arduino e inviarlo tramite seriale!
            voltaggio_batteria = 5

            #salvo i dati nel database
            saveData(id_stazione, temp, voltaggio_batteria, ID_SENSORE_TEMPERATURA)
            saveData(id_stazione, hum, voltaggio_batteria, ID_SENSORE_UMIDITA)
            saveData(id_stazione, press, voltaggio_batteria, ID_SENSORE_PRESSIONE)
except serial.SerialException:
    print("Ricevitore non trovato")
        
