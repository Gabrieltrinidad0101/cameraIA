from server.src.socket.camera.utils.days_controller import get_current_day,get_next_day
import pytest

@pytest.mark.parametrize(
    "days,expected",
    [
        (["Sunday","Monday"],["Sunday","Monday","Tuesday"]),
        (["Sunday","Tuesday"], ["Sunday","Monday","Tuesday","Wednesday"]),
        (["Monday","Sunday"], ["Monday","Tuesday","Sunday"]),
        (["Tuesday"], ["Tuesday","Wednesday"]),
        (["Thursday"], ["Thursday","Friday"]),
        (["Thursday","Sunday"], ["Thursday","Friday","Sunday","Monday"]),
    ]
)
def test_get_next_day(days,expected):
    days_with_next_days = get_next_day(days)
    assert days_with_next_days == expected