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

