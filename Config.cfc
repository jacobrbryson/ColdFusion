component{
    this.IsProd                 = false;
    this.Version                = "v1";
    this.Name                   = "Example";
    this.DataSource             = "ExampleDatabase";
    this.BaseWebURL             = "https://www.example.com";
    this.AssetsURL              = "https://assets.example.com";
    this.Theme.Color            = "##FFF";

    this.SessionManagement      = true;
    this.ApplicationTimeout     = CreateTimeSpan(30, 0, 0, 0); //30 days
    this.SessionTimeout         = CreateTimeSpan(7, 0, 0, 0); //7 days
    this.SessionCreated         = DateTimeFormat(now(),"yyyy-mm-dd HH:nn:ss");

    this.Google.ClientID        = "<GOOGLE CLIENT_ID>";
    this.Google.ClientSecret    = "<GOOGLE CLIENT_IDSECRET>";
    this.Google.AuthEndPoint    = "_auth.cfm";
}