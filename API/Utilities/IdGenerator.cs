namespace API.Utilities
{
    public static class IdGenerator
    {
        public static string GenerateUniqueId()
        { 
            string timeComponent = DateTime.UtcNow.ToString("yyMMdd"); 
            Random random = new Random();
            string randomComponent = random.Next(1000, 9999).ToString(); 
            return timeComponent + randomComponent; 
        }

    }
}
