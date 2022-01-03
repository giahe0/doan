using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Text;

namespace doan.Models
{
    public class Security
    {
        /// <summary>
        /// Hàm phục vụ cho mục đích mã hoá một chuỗi văn bản gốc dựa vào việc băm dữ liệu bởi SHA256
        /// </summary>
        /// <param name="PlainText">Chuỗi văn bản muốn mã hoá</param>
        /// <returns>Kết quả đã mã hoá</returns>
        public static string encrytSHA256(string PlainText)
        {
            string result = "";
            //---tạo đối tượng mã hoá--------
            using(SHA256 mahoa = SHA256.Create())
            {
                //-----Chuyển đổi chuỗi mã hoá thành 1 mảng các bytes--------
                byte[] sourceData = Encoding.UTF8.GetBytes(PlainText);
                //-----Gọi thuật toán để chia nhỏ mảng---------
                byte[] hashResult = mahoa.ComputeHash(sourceData);
                result = BitConverter.ToString(hashResult);
            }    
            return result;
        }
    }
}