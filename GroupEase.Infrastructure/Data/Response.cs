//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace GroupEase.Infrastructure.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class Response
    {
        public int surveyResponseId { get; set; }
        public int questionId { get; set; }
        public int userId { get; set; }
        public string answer { get; set; }
    
        public virtual Question Question { get; set; }
        public virtual SurveyResponse SurveyResponse { get; set; }
        public virtual User User { get; set; }
    }
}
