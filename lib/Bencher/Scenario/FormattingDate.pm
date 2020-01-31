package Bencher::Scenario::FormattingDate;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use DateTime;

my $date1_epoch  = 1580445227; # 2020-01-31T04:33:47Z
my $date1_gmtime = [gmtime $date1_epoch];
my $date1_dt    = DateTime->new(
    time_zone => 'UTC',
    year   => 2020,
    month  => 1,
    day    => 31,
    hour   => 4,
    minute => 33,
    second => 47,
);
my $date1_year  = $date1->year;
my $date1_month = $date1->month;
my $date1_day   = $date1->day;

our $scenario = {
    summary => 'Benchmark various methods of formatting date',
    participants => [
        {
            name => 'strftime',
            fcall_template=>'POSIX::strftime(<format_strftime>, @{<date_gmtime>})',
        },
        {
            name => 'strftimeq',
            fcall_template=>'Date::strftimeq::strftimeq(<format_strftime>, @{<date_gmtime>})',
        },
        {
            name => 'DateTime::Format::ISO8601::Format::format_date',
            module => 'DateTime::Format::ISO8601::Format',
            code_template=>'DateTime::Format::ISO8601::Format->new->format_date(<date_dt>)',
        },
        {
            name => 'DateTime::Format::ISO8601::Format::format_datetime',
            module => 'DateTime::Format::ISO8601::Format',
            code_template=>'DateTime::Format::ISO8601::Format->new->format_datetime(<date_dt>)',
        },
        {
            name => 'Date::Formatter',
            module => 'Date::Formatter',
            code_template=>'Date::Formatter->new(year=><date_year>, month=><date_month>, )',
        },
    ],
    datasets => [
        {name=>'YYYY-mm-dd', args=>{
            format_strftime => '%Y-%m-%d',
            date_epoch  => $date1_epoch,
            date_gmtime => $date1_gmtime,
            date_dt     => $date1_dt,
            date_year   => $date1_year,
            date_month  => $date1_month,
            date_day    => $date1_day,
        }},
    ],
};

1;
# ABSTRACT:
