using System.ComponentModel.DataAnnotations;

namespace LibraryLendingSystem_Service.User.Models.Vms
{
    public class Login
    {
        [Required]
        [StringLength(10)]
        [Display(Name = "手機號碼")]
        public string PhoneNumber { get; set; }

        [Required]
        [StringLength(10)]
        [Display(Name = "密碼")]
        public string Password { get; set; }
    }
}
