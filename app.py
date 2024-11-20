from flask import Flask, render_template, request
import mysql.connector

# app.py susieta su mysql
class Database:
    def __init__(self):
        self.connection = mysql.connector.connect(
            host="localhost",
            user="root",
            password="DuomenuBaze20031114",
            database="AkademineSistema"
        )
        self.cursor = self.connection.cursor()

    def execute_query(self, query, params=None):
        self.cursor.execute(query, params)
        return self.cursor

    def commit(self):
        self.connection.commit()

    def close(self):
        self.cursor.close()
        self.connection.close()

# klases: studentas destytojas adminas
class Vartotojas:
    def __init__(self, vardas, slaptazodis):
        self.vardas = vardas
        self.slaptazodis = slaptazodis

    def prisijungti(self):
        raise NotImplementedError("Šis metodas turi būti įgyvendintas subclass'uose")

class Studentas(Vartotojas):
    def prisijungti(self, db):
        query = "SELECT * FROM Naudotojai WHERE Vardas = %s AND Slaptazodis = %s AND VartotojoTipas = 'Studentas'"
        result = db.execute_query(query, (self.vardas, self.slaptazodis)).fetchone()
        return result

class Destytojas(Vartotojas):
    def prisijungti(self, db):
        query = "SELECT * FROM Naudotojai WHERE Vardas = %s AND Slaptazodis = %s AND VartotojoTipas = 'Destytojas'"
        result = db.execute_query(query, (self.vardas, self.slaptazodis)).fetchone()
        return result

class Administratorius(Vartotojas):
    def prisijungti(self, db):
        query = "SELECT * FROM Naudotojai WHERE PrisijungimoVardas = %s AND Slaptazodis = %s AND VartotojoTipas = 'Administratorius'"
        result = db.execute_query(query, (self.vardas, self.slaptazodis)).fetchone()
        return result

# Flask
app = Flask(__name__)
db_instance = Database()

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/redirect', methods=['POST'])
def redirect_role():
    role = request.form.get('role')
    if role == "Administratorius":
        return render_template('admin.html')
    elif role == "Dėstytojas":
        return render_template('destytojas_login.html')
    elif role == "Studentas":
        return render_template('student_login.html')
    else:
        return "Neteisinga rolė"

# loginas studentui
@app.route('/student_login', methods=['POST'])
def student_login():
    vardas = request.form.get('vardas')
    slaptazodis = request.form.get('slaptazodis')
    studentas = Studentas(vardas, slaptazodis)

    if studentas.prisijungti(db_instance):
        query = """
        SELECT DestomiDalykai.DalykoPavadinimas, Pazymiai.Pazymys
        FROM Pazymiai
        JOIN DestomiDalykai ON Pazymiai.DalykasID = DestomiDalykai.ID
        WHERE Pazymiai.StudentasID = (
            SELECT ID FROM Naudotojai WHERE Vardas = %s AND Slaptazodis = %s
        )
        """
        pazymiai = db_instance.execute_query(query, (vardas, slaptazodis)).fetchall()
        return render_template('studentas.html', vardas=vardas, pazymiai=pazymiai)
    else:
        return "Neteisingas vardas arba slaptažodis"

# loginas destytojui
@app.route('/destytojas_login', methods=['POST'])
def destytojas_login():
    vardas = request.form.get('vardas')
    slaptazodis = request.form.get('slaptazodis')
    destytojas = Destytojas(vardas, slaptazodis)

    if destytojas.prisijungti(db_instance):
        studentai = db_instance.execute_query("SELECT ID, Vardas, Pavarde FROM Naudotojai WHERE VartotojoTipas = 'Studentas'").fetchall()
        dalykai = db_instance.execute_query("SELECT DISTINCT ID, DalykoPavadinimas FROM DestomiDalykai").fetchall()
        return render_template('destytojas.html', studentai=studentai, dalykai=dalykai)
    else:
        return "Neteisingas vardas arba slaptažodis"

# loginas adminui
@app.route('/admin_login', methods=['POST'])
def admin_login():
    vardas = request.form.get('vardas')
    slaptazodis = request.form.get('slaptazodis')
    administratorius = Administratorius(vardas, slaptazodis)

    if administratorius.prisijungti(db_instance):
        return render_template('admin_valdymas.html')
    else:
        return "Neteisingas prisijungimo vardas arba slaptažodis"

# pazymio updeitas
@app.route('/pazymio_update', methods=['POST'])
def update_grade():
    studentas_id = request.form.get('studentas_id')
    dalykas_id = request.form.get('dalykas_id')
    pazymys = request.form.get('pazymys')

    # iraso tikrinimas
    check_query = "SELECT * FROM Pazymiai WHERE StudentasID = %s AND DalykasID = %s"
    existing_record = db_instance.execute_query(check_query, (studentas_id, dalykas_id)).fetchone()

    if existing_record:
        # jei yra irasas tai atnaujina pazymy
        update_query = "UPDATE Pazymiai SET Pazymys = %s WHERE StudentasID = %s AND DalykasID = %s"
        db_instance.execute_query(update_query, (pazymys, studentas_id, dalykas_id))
    else:
        # jei nera sukuria irasas
        insert_query = "INSERT INTO Pazymiai (StudentasID, DalykasID, Pazymys) VALUES (%s, %s, %s)"
        db_instance.execute_query(insert_query, (studentas_id, dalykas_id, pazymys))

    db_instance.commit()  # patvirtina mysql

    return render_template('pazymio_update.html')

# adina studenta
@app.route('/add_student', methods=['POST'])
def add_student():
    vardas = request.form.get('vardas')
    pavarde = request.form.get('pavarde')
    prisijungimo_vardas = request.form.get('prisijungimo_vardas')
    slaptazodis = request.form.get('slaptazodis')

    query = """
        INSERT INTO Naudotojai (Vardas, Pavarde, VartotojoTipas, PrisijungimoVardas, Slaptazodis)
        VALUES (%s, %s, 'Studentas', %s, %s)
    """
    db_instance.execute_query(query, (vardas, pavarde, prisijungimo_vardas, slaptazodis))
    db_instance.commit()
    return render_template('pridetas_studentas.html')

if __name__ == '__main__':
    app.run(debug=True)
