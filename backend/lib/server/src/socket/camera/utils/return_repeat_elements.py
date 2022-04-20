def return_repeat_elements(list1,list2):
    list_cotainer = []
    for i in list1:
        if i in list2:
            list_cotainer.append(i)
    return list_cotainer
