# relational-databases
[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/W7o16UfH)
# Graded Challenge 1

_Graded Challenge ini dibuat guna mengevaluasi pembelajaran pada Hacktiv8 Comprehensive Data Analytics Program khususnya pada konsep Relational Database._

---

## Assignment Instructions

*Graded Challenge 1* dikerjakan dalam format  **SQL Query (.sql)** dengan beberapa **kriteria wajib** di bawah ini:

1. *Project* dinyatakan selesai dan diterima untuk dinilai jika file .sql dapat dirun dengan baik dan dapat mengeluarkan output yang diinginkan.

2. Pada tugas Graded Challenge 1, akan diminta untuk membuat:
   - Satu file **.sql** yang berisikan query untuk membuat database dari data yang diolah dengan Pandas.
   - Satu file gambar yang menjelaskan ERD database.

3. File .sql **wajib** diberikan keterangan atau pengenalan dengan menggunakan `comment` yang berisikan Judul tugas, Nama, Batch, dan penjelasan singkat tentang program yang dibuat, fitur-fitur. Contoh:
    ```sql
    /*
    =================================================
    Graded Challenge 2

    Nama  : Fahmi Iman Alfarizki
    Batch : CODA-RMT-001

    Program ini dibuat untuk melakukan automatisasi pengolahan (cleaning) data text yang berguna untuk pemodelan model analisa sentimen.
    =================================================
    */
    ```
4. Berikan keterangan pada tiap satu query (yang diakhiri dengan tanda `;`) berupa comment. Contoh:
   ```sql
   -- Query di bawah untuk mendapatkan semua data dari tabel Students.
   SELECT * FROM Students;

   -- Query di bawah untuk mendapatkan list batch yang ada.
   SELECT DISTINCT batch from Students;
   ```

5. **WARNING**: Plagiarisme sekecil apapun dapat terdeteksi. Tugas ini akan diuji tingkat plagiarismenya dengan software khusus.

---

## Assignment Submission

- Simpan assignment pada Graded Challenge 1 ini dengan nama `P0G1_<nama-student>.sql` (file .sql) dan `P0G1_<nama-student>.jpg` (file gambar dengan ekstensi apapun yang populer seperti .jpg, .png). Notes: **Maksimal nama dua suku kata**.
- Push file Assigment yang telah dibuat ke repository Github Classroom masing-masing student.

---

## Assignment Objectives

*Graded Challenge 1* ini dibuat guna mengevaluasi konsep Relational Database dan Pandas sebagai berikut:

- Mampu menerapkan normalisasi pada data
- Merancang ERD dari permasalahan yang ada
- Mampu membuat database di PostgreSQL (DDL)
- Mampu membuat tabel dengan query (DDL)
- Mampu mengisi data ke tabel (DML)

---

## Dataset Information

Dataset yang digunakan sudah ada di dalam repository soal dengan nama `movies.csv`. Berikut informasi kolom:

|Kolom|Tipe Data|
|---|---|
|id|Varchar|
|title|Varchar/Text|
|type|Varchar/Text|
|description|Varchar/Text|
|release_year|Integer|
|age_certification|Varchar/Text|
|runtime|Integer|
|genre|Array|
|production_countries|Array|

---

## Assignment Instructions and Cases

Kamu adalah seorang Data Engineer yang diminta untuk mengelola data film untuk sebuah perusahaan penyedia layanan streaming. Kamu perlu melakukan langkah-langkah berikut ini:

### 1. Membuat Database
Buat database untuk menyimpan data film yang tersedia pada file movies.csv.

### 2. Membuat Tabel Staging
Buat tabel `Staging` untuk melakukan penyimpanan data sementara, kemudian insert data csv ke tabel dengan contoh query sebagai berikut:
```sql
COPY Tabel_Name(col1, col2, col3, col4, col5)
FROM 'C:\tmp\persons.csv'
DELIMITER ','
CSV HEADER;
```
Notes: simpan semua file csv yang akan dibaca oleh sql ke folder tmp (Windows= `C:\tmp\` dan Mac/Linux= `/tmp/` supaya mempermudah.

### 3. Menormalisasi Data
- Lakukan normalisasi data film dari file movies.csv. Kamu perlu membuat struktur tabel sesuai dengan proses normalisasi hingga mencapai bentuk yang paling sederhana (1NF, 2NF, atau sampai 3NF).
- Jumlah tabel setelah dinormalisasi sebanyak 3 tabel termasuk tabel utama (tidak termasuk tabel Staging).
- Kemudian simpan semua tabel yang dihasilkan ke dalam file csv. Berikan nama file sesuai dengan nama tabel yang akan digunakan pada database. Jangan lupa index dataframe tidak perlu diikutsertakan dalam file karena skema tabel akan menerapkan auto incremental untuk pengisian primay key

### 3. Membuat Tabel dan Mengisi Data
- Gunakan DDL (Data Definition Language) untuk membuat tabel-tabel dari langkah 3, kemudian gunakan DML (Data Manipulation Language) untuk mengisi data ke dalam tabel dari file movies.csv.
- Untuk insert data dari query SQL langsung, kamu bisa mengikuti contoh berikut:
     ```sql
         INSERT INTO NEW_TABEL(col1,col2,col3) SELECT col1,col2,col3 FROM TABEL
     ```
- Hati-hati dalam mendefinisikan tipe data di setiap kolom terutama array.
- Hint: Untuk memecah array menjadi multiple row, dapat menggunakan keyword `UNNEST` pada query.
     ```sql
     tabelA
     |col1|
     |{1,2,3}|

     SELECT UNNEST(col1) as new_col FROM tabelA;

     tabelA
     |new_col|
     |   1   |
     |   2   |
     |   3   |
     ```

### 4. Pengujian Database
Setelah tabel berhasil dibuat, lakukan query berikut untuk menguji database yang kamu buat:

1. Tampilkan semua film dengan genre dan negara produksinya.
2. Genre film yang paling populer.
3. Negara yang paling banyak membuat film.

---

## Assignment Rubrics
|**Key Component**|**Description**|**Points**|
|---|---|---|
|Data Normalization|Mampu melakukan normalisasi pada data dengan benar|4 pts|
|Data Definition Language|Mampu membuat database dan tabel dengan tipe data yang sesuai|6 pts|
|Data Manipulation|Mampu menambahkan data dari CSV dan dari Query ke tabel yang sudah dibuat|6 pts|
|Data Query Language|Mampu melakukan query sesuai dengan soal|9 pts|

**Total: 25 pts**

---
## Score Reduction

Jika Student terlambat mengumpulkan dengan waktu yang ditentukan, maka Graded Challenge akan diberi poin nol.

---

