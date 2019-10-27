/**
 * bullseye viewer utils
 */

// init ajax
$.ajaxSetup({xhrFields: {withCredentials: true}, async: false});

// util functions
let _formatDate = function (start_at) {
}

function viewer_formatRound(problem_id, round_id) {
    if (PROBLEMS[problem_id]['round'][round_id] === undefined) {
        return `R-`
    }

    let start_date = new Date(Date.parse(PROBLEMS[problem_id]['round'][1]['start_at']))
    let date = new Date(Date.parse(PROBLEMS[problem_id]['round'][round_id]['start_at']))
    let day = (date.getDate() - start_date.getDate() + 1)
    let hour = ('0' + date.getHours()).slice(-2)
    let min = ('0' + date.getMinutes()).slice(-2)
    return `R${round_id} (${day}day ${hour}:${min})`
}

// super globals
window.PROBLEMS = {}
$.getJSON(CONFIG.API_BASE + '/problems.json', (r) => {
    window.PROBLEMS = r
    for (let problem_id in r) {
        let round = Object.keys(r[problem_id]['round'])
        window.PROBLEMS[problem_id]['min_round'] = Math.min(...round)
        window.PROBLEMS[problem_id]['max_round'] = Math.max(...round)
    }
})

// finalize
$.ajaxSetup({async: true});
