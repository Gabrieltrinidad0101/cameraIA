from server.src.socket.camera.utils.return_repeat_elements import return_repeat_elements
import pytest

@pytest.mark.parametrize(
    "input_a,input_b,expected",
    [
        ([1,2,3,4],[1,3],[1,3]),
        ([2,5,6,8,34],[3,23,457,8],[8]),
        ([66,77,66],[445,665],[]),
        ([1,2,3,444,444],[444,444,444],[444,444]),
    ]
)
def test_return_repeat_elements(input_a,input_b,expected):
    array_of_repeat_elements = return_repeat_elements(input_a,input_b)
    assert array_of_repeat_elements == expected
