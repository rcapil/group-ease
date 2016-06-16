namespace GroupEase.Core.Model
{
    public class User
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Salt { get; set; }
        public string SaltedHash { get; set; }
    }
}
