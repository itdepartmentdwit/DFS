/// <reference path="Forms/Employee.js" />


function DecOrderQuantity(me) {
    var txtOrdQuan = $(me).next().get(0);
    var ordQuan = $.trim($(txtOrdQuan).val());

    if (isNaN(ordQuan)) {
        return;
    }
    ordQuan = parseInt(ordQuan);

    if (ordQuan == 0) {

        console.log(ordQuan);
        $(txtOrdQuan).val('');
        $(txtOrdQuan).trigger('change');
    }

    if (ordQuan > 0) {
        ordQuan -= 1;

        if (ordQuan == 0) {
            $(txtOrdQuan).val('');
            $(txtOrdQuan).trigger('change');
        } else {
            $(txtOrdQuan).val(ordQuan);
            $(txtOrdQuan).trigger('change');
        }
    }
    return;
}

function IncOrderQuantity(me) {

    var txtOrdQuan = $(me).prev().get(0);
    var ordQuan = $.trim($(txtOrdQuan).val());

    if (isNaN(ordQuan)) {
        return;
    }

    if (ordQuan == '') {
        ordQuan = 0;
    }

    ordQuan = parseInt(ordQuan);
    ordQuan += 1;

    $(txtOrdQuan).val(ordQuan);
    $(txtOrdQuan).trigger('change');

    return;
}