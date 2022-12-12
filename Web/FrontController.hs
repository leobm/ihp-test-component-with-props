module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)
import Web.Component.Counter

-- Controller Imports
import Web.Controller.Static
import IHP.ServerSideComponent.RouterFunctions (routeComponent)

instance FrontController WebApplication where
    controllers = 
        [ startPage WelcomeAction
        -- Generator Marker
         , routeComponent @Counter
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
