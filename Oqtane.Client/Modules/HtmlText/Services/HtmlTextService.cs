using System.Net.Http;
using System.Threading.Tasks;
using Oqtane.Documentation;
using Oqtane.Services;
using Oqtane.Shared;

namespace Oqtane.Modules.HtmlText.Services
{
    [PrivateApi("Mark HtmlText classes as private, since it's not very useful in the public docs")]
    public class HtmlTextService : ServiceBase, IHtmlTextService, IService
    {        
        public HtmlTextService(HttpClient http, SiteState siteState) : base(http, siteState) {}

        private string ApiUrl => CreateApiUrl("HtmlText");

        public async Task<Models.HtmlText> GetHtmlTextAsync(int moduleId)
        {
            return await GetJsonAsync<Models.HtmlText>(CreateAuthorizationPolicyUrl($"{ApiUrl}/{moduleId}", EntityNames.Module, moduleId));
        }

        public async Task AddHtmlTextAsync(Models.HtmlText htmlText)
        {
            await PostJsonAsync(CreateAuthorizationPolicyUrl($"{ApiUrl}", EntityNames.Module, htmlText.ModuleId), htmlText);
        }

        public async Task UpdateHtmlTextAsync(Models.HtmlText htmlText)
        {
            await PutJsonAsync(CreateAuthorizationPolicyUrl($"{ApiUrl}/{htmlText.HtmlTextId}", EntityNames.Module, htmlText.ModuleId), htmlText);
        }

        public async Task DeleteHtmlTextAsync(int moduleId)
        {
            await DeleteAsync(CreateAuthorizationPolicyUrl($"{ApiUrl}/{moduleId}", EntityNames.Module, moduleId));
        }
    }
}
