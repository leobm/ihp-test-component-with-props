module Web.View.Static.Welcome where
import Web.View.Prelude
import Web.Component.Counter
import IHP.ServerSideComponent.ViewFunctions

data WelcomeView = WelcomeView

instance View WelcomeView where
    html WelcomeView = [hsx|
        {counter}
    |]
        where
            counter = componentWithProps @Counter $ CounterProps { count = 10 }
