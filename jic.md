// This is a shopify custom navbar
<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container">
        
        <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </a>
        
        <%= link_to 'Shopify Demo App', '/', :class => 'brand' %>
        
        <% if shop_session %>
          <div class="nav-collapse">
            <ul class="nav">
              <li class='<%= active_nav_class('home', 'index') %>'><%= link_to 'Where to Start', '/' %></li>
              <li class='<%= active_nav_class('home', 'design') %>'><%= link_to 'Bootstrap Info', '/design' %></li>
            </ul>
          </div>
          
          <ul class="nav pull-right">
            <li class="dropdown">
              <%= link_to raw(shop_session.url+' <b class="caret"></b>'), "https://#{shop_session.url}", :class => 'shop_name dropdown-toggle', :'data-toggle' => 'dropdown', :'data-target' => '#' %>
              <ul class="dropdown-menu">
                <li><%= link_to raw('<i class="icon-home"></i> Storefront'), "http://"+shop_session.url, :target => 'blank' %></li>
                <li><%= link_to raw('<i class="icon-cog"></i> Shopify Admin'), "http://"+shop_session.url+"/admin", :target => 'blank' %></li>
                <li class="divider"></li>
                <li><%= link_to raw('<i class="icon-off"></i> Logout'), logout_path, :method => :delete %></li>
              </ul>
            </li>
          </ul>
        <% end %>
        
      </div>
    </div>
  </div>