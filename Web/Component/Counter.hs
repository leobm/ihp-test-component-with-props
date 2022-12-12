module Web.Component.Counter where

import IHP.ViewPrelude
import IHP.ServerSideComponent.Types
import IHP.ServerSideComponent.ControllerFunctions
import Data.Aeson
import GHC.Generics

-- The state object
data Counter = Counter { value :: !Int }

-- The set of actions
data CounterController
    = IncrementCounterAction
    | SetCounterValue { newValue :: !Int }
    deriving (Eq, Show, Data)

$(deriveSSC ''CounterController)

data CounterProps = CounterProps { count :: !Int } deriving (Eq, Show, Generic)
instance Data.Aeson.FromJSON CounterProps
instance Data.Aeson.ToJSON CounterProps

instance Component Counter CounterController CounterProps where
    initialState (Just (CounterProps {count})) = Counter { 
        value = count
    }

    initialState Nothing = Counter { value = 0 }

    -- The render function
    render Counter { value } = [hsx|
        {renderScript}
        Current: {value} <br />
        <button onclick="Counter.incrementAction(this)">Plus One</button>
        <hr />
        <input type="number" value={inputValue value} onchange="Counter.setCounterValueAction(this)"/>
    |]

    -- The action handlers
    action state IncrementCounterAction = do
        state
            |> incrementField #value
            |> pure

    action state SetCounterValue { newValue } = do
        state
            |> set #value newValue
            |> pure

instance SetField "value" Counter Int where setField value' counter = counter { value = value' }

renderScript = [hsx|
    <script>
        const Counter = {
            incrementAction: debounce((el) => {
              callServerAction('IncrementCounterAction', null, el);
            },50),
            setCounterValueAction: debounce((el) => {
                callServerAction('SetCounterValue', { newValue: parseInt(el.value,10) }, el);
            },50)
        } 
    </script>
|]