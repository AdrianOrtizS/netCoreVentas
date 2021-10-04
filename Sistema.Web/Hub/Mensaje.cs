
using Microsoft.AspNetCore.SignalR;

using System;
using System.Threading.Tasks;

namespace Sistema.Web.Hub
{

    public class Mensaje : DynamicHub
    {

        public async Task sendMessage(string group)
        {
            await Clients.Group(group).SendAsync("ReceiveMessage", "hoooola");
        }


        public async Task AddToGroup(string groupName)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, groupName);
        }


    }

}
