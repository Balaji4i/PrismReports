create or replace PACKAGE "XXPM_BOOK_MS_REV_PKG" IS
    PROCEDURE get_milestones (
        p_rev_hdr_id      IN   NUMBER,
        p_booking_hdr_id  IN   NUMBER,
        p_func_id         IN   NUMBER,
        retcode           OUT  NUMBER,
        errbuf            OUT  VARCHAR2
    );

    PROCEDURE update_milestones (
        p_rev_hdr_id      IN   NUMBER,
        p_booking_hdr_id  IN   NUMBER,
        p_username        IN   VARCHAR2,
        msg               OUT  VARCHAR2,
        msg_code          OUT  VARCHAR2,
        p_delet_count     OUT  VARCHAR2,
        p_new_count       OUT  VARCHAR2,
        p_update_count    OUT  VARCHAR2
    );

    FUNCTION get_customername (
        p_booking_id IN xxpm_booking_customer.booking_hdr_id%TYPE
    ) RETURN VARCHAR2;

    FUNCTION get_customersite (
        p_booking_id IN xxpm_booking_customer.booking_hdr_id%TYPE
    ) RETURN NUMBER;

    FUNCTION get_customersitename (
        p_booking_id IN xxpm_booking_customer.booking_hdr_id%TYPE
    ) RETURN VARCHAR2;

    PROCEDURE get_updated_milestones (
        p_rev_hdr_id      IN  NUMBER,
        p_booking_hdr_id  IN  NUMBER
    );

    FUNCTION get_line_amt (
        p_total_spa  IN  NUMBER,
        p_tax_code   IN  VARCHAR2,
        p_tax_perc   IN  NUMBER
    ) RETURN NUMBER;

    FUNCTION get_tax_amt (
        p_total_spa  IN  NUMBER,
        p_tax_code   IN  VARCHAR2,
        p_tax_perc   IN  NUMBER
    ) RETURN NUMBER;

    PROCEDURE update_cp_unit (
        cp_number         IN  VARCHAR2,
        p_booking_hdr_id  IN  NUMBER
    );

END xxpm_book_ms_rev_pkg;
