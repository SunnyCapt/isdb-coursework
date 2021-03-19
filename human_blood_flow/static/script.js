const defaultHeaderText = "ISDB kursach by SunnyCapt";

let updatingTask = null;
let person = null;

function prepareUrl(url) {
    if (url.startsWith('http://') && window.location.toString().startsWith('https://'))
        return `https://${url.substr(7, url.length - 7)}`
    else if (url.startsWith('https://') && window.location.toString().startsWith('http://'))
        return `http://${url.substr(8, url.length - 8)}`
    return url;
}

function runSounds() {
    Array('psx.wav', 'boon.wav').forEach(v => {
        let audio = new Audio('/static/sound/' + v);
        audio.loop = true;
        audio.autoplay = true;
        audio.play().catch(err => {
            document.getElementById('gf1').addEventListener('click', runSounds)
        });
        document.getElementById('gf1').removeEventListener('click', runSounds);
    });
}

function showMsg(msg) {
    document.querySelector('#msg').textContent = msg;
}

function resetMsg() {
    showMsg(defaultHeaderText);
}

function resetInput() {
    document.querySelector('#head input').value = '';
}

function setPersonInfoVisibility(value) {
    document.querySelectorAll('div[id$="-block"]')
        .forEach(e => e.style.visibility = value);
    if (value === 'hide')
        resetMsg()
}

function hidePersonInfoVisibility() {
    setPersonInfoVisibility('hidden');
}

function showPersonInfoVisibility() {
    setPersonInfoVisibility('visible');
}

function onLoad() {
    resetMsg();
    resetInput();
    runSounds();
}

async function loadPerson(url) {
    let resp = await fetch(prepareUrl(url));
    person = await resp.json();
    console.log(person);
}

async function searchPerson(name) {
    let resp = await fetch(humanEndPoint + `?search=${encodeURIComponent(name)}`);
    resp = await resp.json();
    console.log(resp);
    person = resp.results[0];
}

function resetPersonData() {
    document.getElementById('stats').innerHTML = '';
    document.getElementById('role').innerHTML = '';
    document.getElementById('wealth').innerHTML = '';
    document.getElementById('blood-substances').innerHTML = '';
    document.getElementById('person-activity').innerHTML = '';
    document.getElementById('organism-status').innerHTML = '';
}

function fillPersonData() {
    let status = person.organism.status.shortname
        + ': ' + person.organism.status.description
        + '<br>blood speed: ' + person.organism.circulatory_system.speed;
    let activity = person.activity.shortname
        + '<br>' + person.activity.shordescriptiontname;
    let substances = person.organism.circulatory_system.substances.map(
        o => `${o.shortname} - ${o.harmfulness}`
    ).join('<br>');
    let wealth = `${person.wealth.description}: ${person.wealth.lvl}`;
    let role = `${person.role.description}: ${person.role.shortname}`;
    let stats = `sex: ${person.organism.sex}<br>`
        // + `weight: ${person.organism.weight}<br>`
        // + `height: ${person.organism.height}<br>`
        + `birthday: ${person.organism.birthday}`;
    if (person.organism.date_to_die)
        stats += `<br>date_to_die: ${person.organism.date_to_die}`

    document.getElementById('stats').innerHTML = stats;
    document.getElementById('role').innerHTML = role;
    document.getElementById('wealth').innerHTML = wealth;
    document.getElementById('blood-substances').innerHTML = substances;
    document.getElementById('person-activity').innerHTML = activity;
    document.getElementById('organism-status').innerHTML = status;
}

function onSucceedPersonUpdate() {
    resetMsg();
    resetPersonData();

    fillPersonData();
    showMsg(`${person.first_name} ${person.last_name}`);

    showPersonInfoVisibility();
}

function onFailedPersonUpdate(e) {
    resetInput();
    showMsg(`${e.toString().substr(0, 33)}...`);
    console.log(e)
    resetPersonData();
    if (updatingTask) {
        clearInterval(updatingTask);
    }
    hidePersonInfoVisibility();
}

function onSucceedPersonLoad() {
    fillPersonData();
    showMsg(`${person.first_name} ${person.last_name}`);
    showPersonInfoVisibility();
    updatingTask = setInterval(
        () => loadPerson(person.url).then(() => onSucceedPersonUpdate())
            .catch(onFailedPersonUpdate),
        5 * 1000
    )
}

function onKeyPress(input) {
    if (!window.event || window.event.key !== "Enter")
        return;
    showMsg('Лоадинг, плис вейт...')

    if (updatingTask)
        clearInterval(updatingTask);

    searchPerson(input.value)
        .then(() => onSucceedPersonLoad())
        .catch(e => {
            showMsg(`${e.toString().substr(0, 33)}...`);
            console.log(e)
        });
}


