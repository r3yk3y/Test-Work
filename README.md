## Тестовое задание на вакансию стажер аналитик
### 1. Разработать ER диаграмму по заданной области (скриншотам)
По заданным скриншотам была разработана следующая ER-диаграмма (рис 1), документ расположен в файле 1-diagram.vsdx:
![image](https://user-images.githubusercontent.com/111154683/184446471-c8d4dd79-2393-4b66-95f4-282007d2edec.png)
Рисунок 1 - ER - диаграмма

Можно выделить основные сущности:<br>
- **Client** – содержит информацию о физических лицах, которые вступают во взаимодействие с банком. Информация о Client помогает банку при планировании, разработке продуктов и рекламной деятельности.
- **Pasport** – содержит информацию о паспортных данных физических лиц.
- **Region of registration** – содержит информацию о регионах регистрации физических лиц.
- **Work** – содержит информацию о работах физических лиц.
- **Region of work** – содержит информацию о регионах работы физических лиц.
- **Request** – содержит информацию о заявках кредитования физических лиц. Информация о Request помогает банку при планировании, разработке продуктов и рекламной деятельности.
- **Target**- содержит информацию о целях кредитования физических лиц.
- **Product** – содержит информацию о видах продукта кредитования.
- **Services** – содержит информацию о дополнительных услугах кредитования.
- **request_services** – является связующей таблицей для связи между дополнительными услугами и заявками физических лиц. <br><br>

Для полей приложения в которых предоставлен выбор (выпадающей список), были созданы отдельные сущности. <br>
Для числовых полей выбран тип данных int(для целочисленных значений) и float(для дробных значений с плавающей запятой)<br>
Для строковых переменных выбран тип данных varchar(строковый тип переменной длины)<br>
Для полей с датами выбран формат данных date(хранение дат)<br><br>
В итоге была создана база данных в СУБД – MySql версия 5.37 (рис.2), база данных расположена в файле 1-mysql.sql<br>
![image](https://user-images.githubusercontent.com/111154683/184447230-a338f806-c40c-4ba2-8e8a-2a5bff26be65.png)
Рисунок 2 - Физическая модель БД

### 2. Sql – запрос который возвращает самый популярный вид продукта за текущий год
Данные таблицы «Заявки»
 ![image](https://user-images.githubusercontent.com/111154683/184447351-62a5097b-06e4-43a2-9a56-525371e5c065.png)


Данные таблицы «Вид продукта»
 ![image](https://user-images.githubusercontent.com/111154683/184447406-eb7eec1b-5273-47e7-83e2-9bbbc50ab537.png)


Sql-запрос
 ![image](https://user-images.githubusercontent.com/111154683/184447413-26a32599-e88e-4c85-ae03-8daae1ea5db3.png)

Результат выполненого запроса:
 ![image](https://user-images.githubusercontent.com/111154683/184447431-98cfe9df-61da-4ccf-a5e7-d3a40b3f4f73.png)
<br>
Запрос также продублирован в файле 2-request.sql


### 3.  Алгоритм для расчета графика аннуитетных платежей

Для расчета была использована следующая формула:
![image](https://user-images.githubusercontent.com/111154683/184447443-a6e14028-51e3-42be-8120-985c55c313db.png)

Данная задача была реализована с помощью языка C#<br><br>
Алгоритм работы:
- Предоставляется на выбор получение данных: 1 - из консоли, 2 - из базы данных
- Рассчитывается по указанной выше формуле размер ежемесячного платежа
- С помощью цикла помесячно выводится информация о кредите: (месяц, ежемесячный платеж, основной долг, долг по процентам, остаток основного долга)
- Итоговым результатам является готовая таблица с указанными выше данными.


Листинг кода (код также предоставлен в файле 3-Program.cs):
```csharp
using System;
using MySql.Data.MySqlClient;

namespace Test
{
    class Program
    {
        static void Main(string[] args)
        {
            double[] data = new double[3];

            Console.Write("Выберите тип ввода: (1 - ввод с консоли, 2 из БД): ");
            int type = Convert.ToInt32(Console.ReadLine());
            if (type == 1) {
                data = GetFromString();
            } else {
                data = GetFromDataBase();
            }

            double amount = data[0];
            double rate = data[1];
            double term = data[2];

            double pay = amount * (rate / (1 - Math.Pow((1 + rate), -term))); // размер ежемесячного платежа
            Console.WriteLine("---------------------------------------------------------------------------------------------------");
            Console.WriteLine("Месяц  Ежемесячный платеж    Основной долг     Долг по процентам    Остаток основного долга");
            Console.WriteLine("---------------------------------------------------------------------------------------------------");
            for (int month = 1; month <= term; month++)
            {
                double prosentPart = amount * rate; // процентная часть
                double debtPart = pay - prosentPart; // долговая часть
                amount -= debtPart; //остаток долга
                 
                Console.WriteLine("{0, 5} {1, 15} {2, 15} {3, 20} {4, 27}", month, FormatNumber(pay), FormatNumber(debtPart), FormatNumber(prosentPart), FormatNumber(Math.Abs(amount)));
  
            }
        }
        public static string FormatNumber(double number)
        {
            return number.ToString("0.##");
        }

        public static double[] GetFromString()
        {
            double[] data = new double[3];
            Console.Write("Cумма кредита: ");
            data[0] = Convert.ToDouble(Console.ReadLine());

            Console.Write("Ставка: ");
            data[1] = Convert.ToDouble(Console.ReadLine()) / 100 / 12;

            Console.Write("Срок (мес.): ");
            data[2] = Convert.ToInt32(Console.ReadLine());

            return data;
        }
        public static double[] GetFromDataBase()
        {
            double[] data = new double[3];
            // Подключение к базе данных
            string cs = @"server=localhost;userid=root;password=;database=test";

            var con = new MySqlConnection(cs);
            con.Open();

            Console.Write("Введите ID заявки из базы данных: ");
            double requestId = Convert.ToDouble(Console.ReadLine());

            var requestCommand = new MySqlCommand(
                "SELECT `Loan_amount_including_services`, `Bet_size`, `credit_term` from `request` " +
                "WHERE `id_request` = " + requestId + " LIMIT 1",
                con);
            MySqlDataReader rdr = requestCommand.ExecuteReader();

            while (rdr.Read())
            {
                data[0] = rdr.GetDouble(0);
                data[1] = Math.Round(rdr.GetDouble(1), 2);
                data[2] = rdr.GetInt32(2);
                Console.WriteLine("Cумма кредита: " + data[0]);
                Console.WriteLine("Ставка: " + data[1]);
                Console.WriteLine("Срок (мес.): " + data[2]);
                data[1] = data[1] / 100 / 12;
            }

            return data;

        }

    }
}
```
**Результат откладки ввод с консоли:**<br>
Данные, на основе которых проводилось тестирование работы функции:<br>
Сумма кредита: 100000<br>
Ставка: 13 <br>
Срок (мес.): 12<br>

  ![image](https://user-images.githubusercontent.com/111154683/184448354-a72cb38c-6ea1-49af-9ba2-a6b51aa2b0d7.png)


 
**Результат откладки ввод из БД:**<br>
Данные, на основе которых проводилось тестирование работы функции:<br>
Сумма кредита: 140000<br>
Ставка: 7.7<br>
Срок (мес.): 36<br>
![image](https://user-images.githubusercontent.com/111154683/184448413-460ce02e-1e37-4e50-a752-60e26dabb7c8.png)

 




